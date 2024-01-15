module Shared.Texture exposing (..)
import Json.Decode as Decode
import Json.Encode as Encode

type alias Texture = 
    {
        name: String
    }

default : Texture
default =
    { name = "NONE"
    }    

decoderTexture : Decode.Decoder Texture
decoderTexture =
    Decode.map Texture
        (Decode.field "name" Decode.string)

encodeTexture : Texture -> Encode.Value
encodeTexture texture =
    Encode.object
        [ ("name", Encode.string texture.name)
        ]        