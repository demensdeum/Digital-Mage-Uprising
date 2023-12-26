module Shared.Model exposing (..)
import Json.Decode as Decode
import Json.Encode as Encode

type alias Model =
    {
        name: String
    }

default: Model
default =
    {
        name = "default"
    }

decoderModel : Decode.Decoder Model
decoderModel =
    Decode.map Model
    (Decode.field "name" Decode.string)

encodeModel : Model -> Encode.Value
encodeModel model = 
    Encode.object
        [ ("name", Encode.string model.name)
        ]    