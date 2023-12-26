-module(world_server).

-export([start/0, canvas_sync/0]).

canvas_sync() ->
    OldCanvas = #{},
    canvas_sync(OldCanvas).

canvas_sync(OldCanvas) ->
    receive
        {PID, synnnc, Msg} ->
            error_logger:info_msg("Received Canvas"),          
            {ok, Canvas} = thoas:decode(Msg),
            UserObjectName = maps:get(<<"userObjectName">>, Canvas),
            Scene = maps:get(<<"scene">>, Canvas),
            Objects = maps:get(<<"objects">>, Scene),
            UserObject = maps:get(UserObjectName, Objects),
            % error_logger:info_msg(UserObject),
            OldScene = maps:get(<<"scene">>, OldCanvas, #{}),
            OldObjects = maps:get(<<"objects">>, OldScene, #{}),
            NewObjects = maps:put(UserObjectName, UserObject, OldObjects),
            NewScene = maps:put(<<"objects">>, NewObjects, OldScene),
            NewCanvas = maps:put(<<"scene">>, NewScene, OldCanvas),
            NewCanvasEncoded = thoas:encode(NewCanvas),
            PID ! {synnnc, NewCanvasEncoded},
            error_logger:info_msg(NewObjects),
            canvas_sync(NewCanvas);
        _ ->
            error_logger:info_msg("Unhadled case"),
            canvas_sync(OldCanvas)
    end.

start() ->
    SceneSync_PID = spawn(world_server, canvas_sync, []),
    register(world_server, SceneSync_PID),
    error_logger:info_msg("World server started - PID: " ++ pid_to_list(SceneSync_PID)),
    SceneSync_PID.