%% @author Roman Sotnikov <retgoat@gmail.com>
%% @doc Web server for erlblog.

-module(erlblog_web).
-author("Roman Sotnikov <retgoat@gmail.com>").
-include_lib("headers.hrl").
-include_lib("erlang_couchdb.hrl").

-export([start/1, stop/0, loop/2]).

%% External API

start(Options) ->
  {DocRoot, Options1} = get_option(docroot, Options),
  Loop = fun (Req) ->
    ?MODULE:loop(Req, DocRoot)
  end,
  mochiweb_http:start([{name, ?MODULE}, {loop, Loop} | Options1]).

stop() ->
  mochiweb_http:stop(?MODULE).

loop(Req, DocRoot) ->
  "/" ++ Path = Req:get(path),
  try
    case dispatcher:dispatch(Req, router:urls()) of
      none ->
        Req:not_found();
      Response ->
        Response
    end
  catch
    Type:What ->
      Report = ["web request failed",
        {path, Path},
        {type, Type}, {what, What},
        {trace, erlang:get_stacktrace()}],
      error_logger:error_report(Report),
    Req:respond({500, [{"Content-Type", ?JSON_H}], list_to_binary(mochijson2:encode([{"code", 500}, {"message", <<"request failed">>}]))})
  end.

%% Internal API

get_option(Option, Options) ->
  {proplists:get_value(Option, Options), proplists:delete(Option, Options)}.

%%
%% Tests
%%
% -ifdef(TEST).
% -include_lib("eunit/include/eunit.hrl").

% you_should_write_a_test() ->
%     ?assertEqual(
%        "No, but I will!",
%        "Have you written any tests?"),
%     ok.

% -endif.
