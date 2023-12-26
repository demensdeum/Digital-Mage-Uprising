module States.CompanyLogo exposing (..)

import Shared.Scene exposing (..)
import Shared.SceneObjectsFactory exposing (..)
import Shared.SceneObject exposing (Type(..))
import Shared.Vector3 as Vector3
import Shared.Model as Model
import Dict exposing (..)
import Shared.Canvas exposing (..)
import Shared.Vector3 as Vector3

screenTime: Int 
screenTime = 
      10000

type alias Substate =
      {
            tick: Int
      }

type Command =
  GoToMainMenu
  | Rendering Substate

scene : Scene
scene =
      {
        name = "Company Logo Scene"
        , objects = Dict.fromList [
            ("Company Logo Skybox", {
                  name = "Company Logo Skybox"
                  , objectType = Skybox
                  , position = Vector3.default
                  , rotation = Vector3.default
                  , texture = {
                        name = "com.demensdeum.logo"
                  }
                  , model = Model.default
                  , isMovable = False
            })
        ]
        , physicsEnabled = False
    }

step: Canvas -> Substate -> Command
step canvas substate =
      if substate.tick < screenTime then
            Rendering  {substate | tick = substate.tick + 1}
      else
            GoToMainMenu         