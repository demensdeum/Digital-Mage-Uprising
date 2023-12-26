%%%-------------------------------------------------------------------
%% @doc myrel public API
%% @end
%%%-------------------------------------------------------------------

-module(myrel_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    myrel_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
