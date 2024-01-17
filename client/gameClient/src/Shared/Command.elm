module Shared.Command exposing (..)

import Json.Decode as Decode
import Json.Encode as Encode
import Shared.Vector3 exposing (..)

type alias Command = 
    {
        name: String
        , commandType: String
        , time: Int
        , position: Vector3
        , rotation: Vector3
    }

commandDecoder : Decode.Decoder Command
commandDecoder =
    Decode.map5 Command
        (Decode.field "name" Decode.string)
        (Decode.field "type" Decode.string)
        (Decode.field "time" Decode.int)
        (Decode.field "position" decoderVector3)
        (Decode.field "rotation" decoderVector3)

encodeCommand : Command -> Encode.Value
encodeCommand command =
    Encode.object
        [ ("name", Encode.string command.name)
        , ("type", Encode.string command.commandType)
        , ("time", Encode.int command.time)
        , ("position", encodeVector3 command.position)
        , ("rotation", encodeVector3 command.rotation)
        ]    