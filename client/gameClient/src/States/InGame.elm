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

type alias Substate =
  {
  }

type Command =
      Update Canvas

initialSubstate: Substate
initialSubstate =
      {
      }

initialCanvas: Int -> Canvas
initialCanvas seed = 
      let userObjectName = randomHeroName <| Random.initialSeed seed in
      {
        scene = initialScene userObjectName,
        message = "Initial InGame Canvas",
        userObjectName = userObjectName
      }

randomHeroName: Random.Seed -> String
randomHeroName seed =
    let (number, newSeed) = Random.step (Random.int 0 1000000) seed in
    "Udod" ++ String.fromInt number

initialScene : String -> Scene
initialScene userObjectName  =
    {
        name = "In Game Scene"
        , objects = Dict.fromList [
            ("Skybox", {
                  name = "Skybox"
                  , objectType = Skybox
                  , position = Vector3.default
                  , rotation = Vector3.default
                  , texture = {
                        name = "com.demensdeum.blue.field"
                  }
                  , model = Model.default
                  , isMovable = False
            }
            )
            , (userObjectName, {
                  name = userObjectName
                  , objectType = Model
                  , position = {
                    x = 2
                    , y = 0
                    , z = -2
                  }
                  , rotation = Vector3.default
                  , texture = Texture.default
                  , model = {
                        name = "com.demensdeum.snowflake"
                  }
                  , isMovable = True
            }
            )
            , ("Map", {
                  name = "Map"
                  , objectType = Model
                  , position = {
                    x = -2
                    , y = -1
                    , z = 0
                  }
                  , rotation = Vector3.default
                  , texture = Texture.default
                  , model = {
                        name = "com.demensdeum.blue.field.map"
                  }
                  , isMovable = False
            }
            )
            , ("Camera", {
                  name = "Camera"
                  , objectType = Camera
                  , position = {
                    x = 2
                    , y = 1
                    , z = 0
                  }
                  , rotation = Vector3.default
                  , texture = Texture.default
                  , model = Model.default
                  , isMovable = True
            }
            )         
        ]
        , physicsEnabled = True
    }

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