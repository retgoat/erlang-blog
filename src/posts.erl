-module (posts).
-author("Roman Sotnikov <retgoat@gmail.com>").
-include_lib("erlang_couchdb.hrl").
-export ([get_all_posts/0, create_new_post/1]).

get_all_posts() ->
  {json, {struct, Data}} = erlang_couchdb:invoke_view(?DB_HOST, ?DB_POSTS_DATABASE, ?DB_POSTS_DOCUMENT_CLASS, ?DB_ALL_POSTS_VIEW, [{"include_docs", "false"}]),
  mochijson2:encode(Data).

create_new_post(Data) ->
  {struct, JSON} = mochijson2:decode(Data),
  {json, {struct, Resp}} = erlang_couchdb:create_document(?DB_HOST, ?DB_POSTS_DATABASE, {struct, JSON}),
  mochijson2:encode(Resp).


