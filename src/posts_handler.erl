-module (posts_handler).
-author("Roman Sotnikov <retgoat@gmail.com>").
-include_lib("erlang_couchdb.hrl").
-include_lib("headers.hrl").
-compile(export_all).

% Get one doc or all docs from DB
get(Req, Doc_id) ->
  case Doc_id of
    [] ->
      {json, {struct, Data}} = erlang_couchdb:invoke_view(?DB_HOST, ?DB_POSTS_DATABASE, ?DB_POSTS_DOCUMENT_CLASS, ?DB_ALL_POSTS_VIEW, [{"include_docs", "false"}]);
    _ ->
      {json, {struct, Data}} = erlang_couchdb:retrieve_document(?DB_HOST, ?DB_POSTS_DATABASE, Doc_id)
  end,
  respond_with_json(Req, Data).

post(Req, _) ->
  Data = Req:recv_body(),
  {struct, JSON} = mochijson2:decode(Data),
  {json, {struct, Resp}} = erlang_couchdb:create_document(?DB_HOST, ?DB_POSTS_DATABASE, {struct, JSON}),
  respond_with_json(Req, Resp).

put(Req, Doc_id) ->
  Data = Req:recv_body(),
  {struct, JSON} = mochijson2:decode(Data),
  {json, {struct, Resp}} = erlang_couchdb:update_document(?DB_HOST, ?DB_POSTS_DATABASE, Doc_id, {struct, JSON}),
  respond_with_json(Req, Resp).

delete(Req, Doc_id) ->
  Data = Req:recv_body(),
  {struct, Json} = mochijson2:decode(Data),
  Rev_id = proplists:get_value(<<"rev">>, Json, null),
  {json, {struct, Resp}} = erlang_couchdb:delete_document(?DB_HOST, ?DB_POSTS_DATABASE, Doc_id, Rev_id),
  respond_with_json(Req, Resp).

% JSON Responder
respond_with_json(Req, Data) ->
  JSON = mochijson2:encode(Data),
  Req:respond({200, [{"Content-Type", ?JSON_H}], JSON}).
