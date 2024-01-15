module Shared.Controls exposing (..)

import Json.Decode as Decode
import Json.Encode as Encode

type alias Controls = 
    {
        name: String
    }

default : Controls
default =
    { name = "NONE"
    }    

decoderControls : Decode.Decoder Controls
decoderControls =
    Decode.map Controls
        (Decode.field "name" Decode.string)

encodeControls : Controls -> Encode.Value
encodeControls controls =
    Encode.object
        [ ("name", Encode.string controls.name)
        ]        