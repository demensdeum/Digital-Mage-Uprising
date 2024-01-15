module Shared.Scene exposing (..)

import Shared.SceneObject exposing (SceneObject, stringFromType, decoderObjectType)
import Shared.Texture exposing(..)
import Shared.Vector3 exposing (Vector3)
import Shared.Model exposing (Model)

import Dict exposing (..)

import Json.Encode as Encode
import Json.Decode as Decode
import Shared.SceneObject exposing (sceneObjectDecoder)
import Shared.Vector3 as Vector3
import Shared.SceneObject exposing (encodeSceneObject)

type alias Scene =
    {
        name : String
        , objects : Dict String SceneObject
        , physicsEnabled: Bool
    }

type alias ServerScene =
    {
        objects : Dict String SceneObject
    }

default: Scene
default = 
    {
        name = "Empty Scene"
        , objects = Dict.empty
        , physicsEnabled = True
    }

copyRotationFromObjectToObject: String -> String -> Scene -> Scene
copyRotationFromObjectToObject sourceObjectName destinationObjectName scene =
    case Dict.get sourceObjectName scene.objects of
        Just sourceObject ->
            setSceneObjectRotation destinationObjectName sourceObject.rotation scene
        Nothing ->
            scene

setSceneObjectRotation: String -> Vector3 -> Scene -> Scene
setSceneObjectRotation name rotation scene =
    case Dict.get name scene.objects of
        Just object ->
            let newRotation = { x = rotation.x , y = rotation.y , z = rotation.z } in
            let newObject = {object | rotation = newRotation } in
                setSceneObject name newObject scene
        Nothing ->
            scene


getSceneObjectPosition: String -> Scene -> Vector3
getSceneObjectPosition name scene =
    case Dict.get name scene.objects of
        Just object ->
            object.position
        Nothing->
            Vector3.default

setSceneObjectPosition: String -> Vector3 -> Scene -> Scene
setSceneObjectPosition name position scene =
    case Dict.get name scene.objects of
        Just object ->
            let newObject = {object | position = position} in
                setSceneObject name newObject scene
        Nothing ->
            scene

getSceneObject: String -> Scene -> Maybe SceneObject
getSceneObject key scene =
    Dict.get key scene.objects

setSceneObject: String -> SceneObject -> Scene -> Scene
setSceneObject key sceneObject scene =
    { scene | objects = Dict.insert key sceneObject scene.objects }

serverSceneFromJsonString: Decode.Decoder ServerScene
serverSceneFromJsonString =
    Decode.map ServerScene
        (Decode.field "objects" <| Decode.dict sceneObjectDecoder)

decodeScene: Decode.Decoder Scene
decodeScene =
    Decode.map3 Scene
        (Decode.field "name" Decode.string)
        (Decode.field "objects" (Decode.dict sceneObjectDecoder))
        (Decode.field "physicsEnabled" Decode.bool)

encodeScene : Scene -> Encode.Value
encodeScene scene =
    Encode.object
        [ ("name", Encode.string scene.name)
        , ("objects", Encode.dict encodeSceneObjectKey encodeSceneObject scene.objects)
        , ("physicsEnabled", Encode.bool scene.physicsEnabled)
        ]

encodeSceneObjectKey: String -> String
encodeSceneObjectKey key = 
    key
