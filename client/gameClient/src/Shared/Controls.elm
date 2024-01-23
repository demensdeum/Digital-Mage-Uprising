module Shared.Controls exposing (..)

import Json.Decode as Decode
import Json.Encode as Encode

type alias Controls = 
    {
        name: String
        , startCommand: String
    }

default : Controls
default =
    { name = "NONE"
    , startCommand = "NONE"
    }    

decoderControls : Decode.Decoder Controls
decoderControls =
    Decode.map2 Controls
        (Decode.field "name" Decode.string)
        (Decode.field "startCommand" Decode.string)

encodeControls : Controls -> Encode.Value
encodeControls controls =
    Encode.object
        [ ("name", Encode.string controls.name)
        , ("startCommand", Encode.string controls.startCommand)
        ]        