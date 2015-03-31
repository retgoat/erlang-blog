-module (posts).
-author("Roman Sotnikov <retgoat@gmail.com>").
-include_lib("erlang_couchdb.hrl").
-export ([get_all_posts/0]).

get_all_posts() ->
  {json, {struct, Data}} = erlang_couchdb:invoke_view(?DB_HOST, ?DB_POSTS_DATABASE, ?DB_POSTS_DOCUMENT_CLASS, ?DB_ALL_POSTS_VIEW, [{"include_docs", "false"}]),
  Resp = proplists:get_value(<<"rows">>, Data),
  mochijson2:encode(Resp).

