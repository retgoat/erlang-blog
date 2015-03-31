%% @author Roman Sotnikov <retgoat@gmail.com>

%% @doc erlblog.

-module(erlblog).
-author("Roman Sotnikov <retgoat@gmail.com>").
-export([start/0, stop/0]).

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.


%% @spec start() -> ok
%% @doc Start the erlblog server.
start() ->
    erlblog_deps:ensure(),
    ensure_started(crypto),
    application:start(erlblog).


%% @spec stop() -> ok
%% @doc Stop the erlblog server.
stop() ->
    application:stop(erlblog).
