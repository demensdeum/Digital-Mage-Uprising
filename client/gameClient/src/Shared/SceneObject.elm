module Shared.SceneObject exposing (..)

import Shared.Vector3 exposing (..)
import Shared.Texture exposing (..)
import Shared.Model exposing (..)
import Json.Decode as Decode
import Json.Encode as Encode
import Shared.Controls exposing (..)
import Json.Decode.Extra exposing (andMap)
import Shared.Vector3 as Vector3

type Type =
    Skybox
    | Model
    | Camera
    | Box
    | Plane
    | Button
    | Entity

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
        Button ->
            "Button"
        Entity ->
            "Entity"

type alias SceneObject = 
    {
        name: String
        , objectType: Type
        , position: Vector3
        , rotation: Vector3
        , texture: Texture
        , model: Model
        , isMovable: Bool
        , controls: Controls
        , changeDate: Int
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
            "Button" -> Decode.succeed Button
            "Entity" -> Decode.succeed Entity
            _ -> Decode.fail "Invalid type"
        )
    ]

sceneObjectDecoder : Decode.Decoder SceneObject
sceneObjectDecoder =
    Decode.succeed SceneObject
        |> andMap (Decode.field "name" Decode.string)
        |> andMap (Decode.field "type" decoderObjectType)
        |> andMap (Decode.field "position" decoderVector3)
        |> andMap (Decode.field "rotation" decoderVector3)
        |> andMap (Decode.field "texture" decoderTexture)
        |> andMap (Decode.field "model" decoderModel)
        |> andMap (Decode.field "isMovable" Decode.bool)
        |> andMap (Decode.field "controls" decoderControls)
        |> andMap (Decode.field "changeDate" Decode.int)

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
        , ("controls", encodeControls sceneObject.controls)
        , ("changeDate", Encode.int sceneObject.changeDate)
        ]