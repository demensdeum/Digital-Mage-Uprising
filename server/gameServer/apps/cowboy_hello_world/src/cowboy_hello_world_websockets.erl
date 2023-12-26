-module(cowboy_hello_world_websockets).

-export([
    init/2,
    websocket_init/1,
    websocket_handle/2,
    websocket_info/2
    ]).

init(Req, State) -> 
    error_logger:info_msg("1"),
    InitialState = #{},
    {cowboy_websocket, Req, InitialState}.

websocket_init(State) ->
    {ok, State}.

websocket_handle({text, Msg}, State) ->
    world_server ! {self(), synnnc, Msg},
    {ok, State};
    
websocket_handle({binary, _Binary}, State) ->
    {ok, State};

websocket_handle(_Frame, State) ->
    {ok, State}.

websocket_info({Command, Info}, State) ->
    error_logger:info_msg("Received something from Erlang!"),
    EncodedInfo = binary_to_list(Info),
    {reply, {text, EncodedInfo}, State}.
