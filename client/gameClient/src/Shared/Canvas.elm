module Shared.Canvas exposing (..)

import Shared.Scene exposing (Scene)
import Json.Encode as Encode
import Json.Decode as Decode
import Shared.Scene as Scene

type alias Canvas =
    { scene : Scene
    , message : String
    , userObjectName : String
    }

type alias ServerCanvas =
    {
        scene: Scene.ServerScene
    }

default: String -> Canvas
default userObjectName = 
    {
        scene = Scene.default
        , message = "Default Message"
        , userObjectName = userObjectName
    }

encodeCanvas: Canvas -> Encode.Value
encodeCanvas canvasState =
    Encode.object
        [ ("scene", Scene.encodeScene canvasState.scene)
        , ("message", Encode.string canvasState.message)
        , ("userObjectName", Encode.string canvasState.userObjectName)
        ]    

canvasFromJsonString: Decode.Decoder Canvas
canvasFromJsonString =
    Decode.map3 Canvas
        (Decode.field "scene" Scene.sceneFromJsonString)
        (Decode.field "message" Decode.string)
        (Decode.field "userObjectName" Decode.string)

serverCanvasFromJsonString: Decode.Decoder ServerCanvas
serverCanvasFromJsonString =
    Decode.map ServerCanvas
        (Decode.field "scene" Scene.serverSceneFromJsonString)

jsonStringFromCanvas: Canvas -> String
jsonStringFromCanvas canvasState =
    Encode.encode 4 (encodeCanvas canvasState)