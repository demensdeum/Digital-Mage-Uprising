module Shared.Vector3 exposing (..)
import Json.Decode as Decode
import Json.Encode as Encode

type alias Vector3 =
    { x : Float
    , y : Float
    , z : Float
    }

default : Vector3
default =
    { x = 0
    , y = 0
    , z = 0
    }

decoderVector3 : Decode.Decoder Vector3
decoderVector3 =
    Decode.map3 Vector3
        (Decode.field "x" Decode.float)
        (Decode.field "y" Decode.float)
        (Decode.field "z" Decode.float)

encodeVector3 : Vector3 -> Encode.Value
encodeVector3 position =
    Encode.object
        [ ("x", Encode.float position.x)
        , ("y", Encode.float position.y)
        , ("z", Encode.float position.z)
        ]