%% @author Mochi Media <dev@mochimedia.com>
%% @copyright erlblog Mochi Media <dev@mochimedia.com>

%% @doc Callbacks for the erlblog application.

-module(erlblog_app).
-author("Mochi Media <dev@mochimedia.com>").

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for erlblog.
start(_Type, _StartArgs) ->
    erlblog_deps:ensure(),
    erlblog_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for erlblog.
stop(_State) ->
    ok.
