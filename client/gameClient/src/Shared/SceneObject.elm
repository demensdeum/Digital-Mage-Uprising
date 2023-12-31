module Shared.SceneObject exposing (..)

import Shared.Vector3 exposing (..)
import Shared.Texture exposing (..)
import Shared.Model exposing (..)
import Json.Decode as Decode
import Json.Encode as Encode

type Type =
    Skybox
    | Model
    | Camera
    | Box
    | Plane

stringFromType: Type -> String
stringFromType objectType =
    case objectType of
        Skybox ->
            "Skybox"
        Model ->
            "Model"
        Camera ->
            "Camera"
        Box ->
            "Box"
        Plane ->
            "Plane"

type alias SceneObject = 
    {
        name: String
        , objectType: Type
        , position: Vector3
        , rotation: Vector3
        , texture: Texture
        , model: Model
        , isMovable: Bool
    }

decoderObjectType : Decode.Decoder Type
decoderObjectType =
  Decode.oneOf
    [ Decode.string
      |> Decode.andThen (\jsonType ->
          case jsonType of
            "Skybox" -> Decode.succeed Skybox
            "Model" -> Decode.succeed Model
            "Camera" -> Decode.succeed Camera
            "Box" -> Decode.succeed Box
            "Plane" -> Decode.succeed Plane
            _ -> Decode.fail "Invalid type"
        )
    ]

sceneObjectDecoder : Decode.Decoder SceneObject
sceneObjectDecoder =
    Decode.map7 SceneObject
        (Decode.field "name" Decode.string)
        (Decode.field "type" decoderObjectType)
        (Decode.field "position" decoderVector3)
        (Decode.field "rotation" decoderVector3)
        (Decode.field "texture" decoderTexture)
        (Decode.field "model" decoderModel)
        (Decode.field "isMovable" Decode.bool)

encodeSceneObject : SceneObject -> Encode.Value
encodeSceneObject sceneObject =
    Encode.object
        [ ("name", Encode.string sceneObject.name)
        , ("type", Encode.string <| stringFromType sceneObject.objectType)
        , ("position", encodeVector3 sceneObject.position)
        , ("rotation", encodeVector3 sceneObject.rotation)
        , ("texture", encodeTexture sceneObject.texture)
        , ("model", encodeModel sceneObject.model)
        , ("isMovable", Encode.bool sceneObject.isMovable)
        ]