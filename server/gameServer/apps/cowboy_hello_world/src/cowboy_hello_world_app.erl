%%%-------------------------------------------------------------------
%% @doc cowboy_hello_world public API
%% @end
%%%-------------------------------------------------------------------

-module(cowboy_hello_world_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    world_server:start(),
    {ok, Pid} = 'cowboy_hello_world_sup':start_link(),
    Routes = [ {
        '_',
        [
            {"/", cowboy_hello_world_websockets, []}
        ]
    } ],
    Dispatch = cowboy_router:compile(Routes),

    TransOpts = [{ip, {127,0,0,1}}, {port, 2938}],

    {ok, _} = cowboy:start_clear(
        chicken_poo_poo, 
    TransOpts, 
#{env => #{dispatch => Dispatch}}
),

    {ok, Pid}.

stop(_State) ->
    ok.

%% internal functions
