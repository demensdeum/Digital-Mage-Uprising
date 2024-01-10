module States.MainMenu exposing (..)

import Shared.Scene exposing (..)
import Shared.SceneObject exposing (Type(..))
import Shared.Texture as Texture
import Shared.Vector3 as Vector3
import Shared.Model as Model
import Dict exposing (..)
import Shared.Canvas exposing (..)


type alias Substate =
  {
  }

initialSubstate: Substate 
initialSubstate =
      {
      }

initialCanvas: Canvas
initialCanvas =
      {
        scene = initialScene,
        message = "Initial Main Menu Canvas",
        userObjectName = ""            
      }

initialScene: Scene
initialScene = 
      {
        name = "Main Menu Scene"
        , objects = Dict.empty
        , physicsEnabled = False
      }

scene : Scene
scene =
    {
        name = "Main Menu Scene"
        , objects = Dict.empty
        , physicsEnabled = False
    }

step: Canvas -> Canvas
step model = 
  model     