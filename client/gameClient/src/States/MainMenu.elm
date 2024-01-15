module States.MainMenu exposing (..)

import Shared.Scene exposing (..)
import Shared.SceneObject exposing (Type(..))
import Shared.Texture as Texture
import Shared.Vector3 as Vector3
import Shared.Model as Model
import Dict exposing (..)
import Shared.Canvas exposing (..)
import Shared.Controls exposing (Controls)
import Shared.Controls as Controls


type alias Substate =
  {
      pressedButtonName: String
  }

type Command =
  Idle
  | StartNewGame

initialSubstate: Substate 
initialSubstate =
      {
            pressedButtonName = "NONE"
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
        , objects = Dict.fromList [
            ("Skybox", {
                  name = "Skybox"
                  , objectType = Skybox
                  , position = Vector3.default
                  , rotation = Vector3.default
                  , texture = {
                        name = "com.demensdeum.space"
                  }
                  , model = Model.default
                  , isMovable = False
                  , controls = Controls.default
            })
            , ("Planet1", {
                  name = "Planet1"
                  , objectType = Model
                  , position = {
                        x = 1.8
                        , y = 1.8
                        , z = -4
                  }
                  , rotation = Vector3.default
                  , texture = Texture.default
                  , model = {
                        name = "com.demensdeum.planet1"
                  }
                  , isMovable = False
                  , controls = Controls.default
            })
            , ("Planet2", {
                  name = "Planet2"
                  , objectType = Model
                  , position = {
                        x = -0.6
                        , y = -0.4
                        , z = -1
                  }
                  , rotation = Vector3.default
                  , texture = Texture.default
                  , model = {
                        name = "com.demensdeum.planet1"
                  }
                  , isMovable = False
                  , controls = Controls.default
            })            
            , ("Planet3", {
                  name = "Planet3"
                  , objectType = Model
                  , position = {
                        x = 10
                        , y = -2
                        , z = -10
                  }
                  , rotation = Vector3.default
                  , texture = Texture.default
                  , model = {
                        name = "com.demensdeum.planet1"
                  }
                  , isMovable = False
                  , controls = Controls.default
            })
            , ("NewGame", {
                  name = "NewGame"
                  , objectType = Button
                  , position = Vector3.default
                  , rotation = Vector3.default
                  , texture = Texture.default
                  , model = Model.default
                  , isMovable = False
                  , controls = Controls.default
            })     
          ]
        , physicsEnabled = False
      }

step: Canvas -> Substate -> Command
step canvas substate = 
      if substate.pressedButtonName == "NewGame" then
            StartNewGame
      else
            Idle
      