module States.InGame exposing (..)

import Shared.Scene exposing (..)
import Shared.SceneObject exposing (Type(..))
import Shared.Texture as Texture
import Shared.Vector3 as Vector3
import Shared.Model as Model
import Dict exposing (..)
import Shared.Canvas exposing (..)
import Shared.Math3 as Math3
import Random
import Shared.Canvas as Canvas
import Shared.Scene as Scene
import Json.Decode as Decode

type InitializationState =
      Started
      | Loading
      | Error
      | Success

type alias Substate =
  {
      initializationState: InitializationState
      , sceneName: String
  }

type Command =
      Update Canvas
      | LoadScene String

initialSubstate: String -> Substate
initialSubstate sceneName =
      {
            initializationState = Started
            , sceneName = sceneName 
      }

initialCanvas: Int -> Canvas
initialCanvas seed = 
      {
        scene = sceneFromJsonString """{"name":"Loading Scene","physicsEnabled":false,"objects":{"Skybox":{"name":"Skybox","type":"Skybox","texture":{"name":"com.demensdeum.space"},"model":{"name":"NONE"},"position":{"x":0,"y":0,"z":0},"rotation":{"x":0,"y":0,"z":0},"isMovable":false,"controls":{"name":"NONE"}}}}"""
        , message = "Initial InGame Canvas Loading..."
        , userObjectName = ""
      }

canvasWithSceneJson: Int -> String -> Canvas
canvasWithSceneJson seed sceneJson =
      let userObjectName = randomHeroName <| Random.initialSeed seed in
      let formattedSceneJson = String.replace "PlayerStartPosition" userObjectName sceneJson in
      let formattedFormattedSceneJson = String.replace "Entity" "Model" formattedSceneJson in
      let scene = sceneFromJsonString formattedFormattedSceneJson in
            canvasWithScene seed scene

canvasWithScene: Int -> Scene -> Canvas
canvasWithScene seed scene =
      let userObjectName = randomHeroName <| Random.initialSeed seed in
      {
            scene = scene
            , message = "InGame Canvas With Scene" ++ scene.name
            , userObjectName = userObjectName
      }

randomHeroName: Random.Seed -> String
randomHeroName seed =
    let (number, newSeed) = Random.step (Random.int 0 1000000) seed in
    "Udod" ++ String.fromInt number

sceneFromJsonString: String -> Scene
sceneFromJsonString sceneJsonString = 
      case Decode.decodeString Scene.decodeScene sceneJsonString  of
            Ok scene ->
                  scene
            Err error ->
                  Scene.default

handleServerCanvas: Canvas.Canvas -> Canvas.ServerCanvas -> Canvas.Canvas
handleServerCanvas oldCanvas serverCanvas =
      let userObjectName = oldCanvas.userObjectName in
      case Dict.get userObjectName oldCanvas.scene.objects of
            Just userObject ->
                  let updatedServerObjects = Dict.insert userObjectName userObject serverCanvas.scene.objects in
                  let newObjects = Dict.union updatedServerObjects oldCanvas.scene.objects in
                  let oldScene = oldCanvas.scene in
                  let newScene = {oldScene | objects = newObjects } in
                  let newCanvas = {oldCanvas | scene = newScene } in
                        newCanvas
            Nothing ->
                  oldCanvas


sendCanvas: Canvas -> Substate -> String
sendCanvas canvas substate =
      Canvas.jsonStringFromCanvas canvas

step: Canvas -> Substate -> Command
step canvas substate =
      case substate.initializationState of
            Started ->
                  LoadScene substate.sceneName
            Loading ->
                  Update canvas
            Error ->
                  Update canvas
            Success ->
                  gameLoopStep canvas substate

gameLoopStep: Canvas -> Substate -> Command
gameLoopStep canvas substate = 
      let aliceName = canvas.userObjectName in
            let bobName = "Camera" in
            case getSceneObject aliceName canvas.scene of
            Just alice ->
                  let newBobPosition = Math3.translate 0 0.8 1.4 alice in
                        let newPositionCanvas = { canvas | scene = Shared.Scene.setSceneObjectPosition bobName newBobPosition canvas.scene } in
                        let newRotationCanvas = { canvas | scene = Shared.Scene.copyRotationFromObjectToObject aliceName bobName newPositionCanvas.scene } in
                              Update {newRotationCanvas | message = "Updated from InGame" }
            Nothing ->
                  Update canvas