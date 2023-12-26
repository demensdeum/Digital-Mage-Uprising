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

scene : Scene
scene =
    {
        name = "Main Menu Scene"
        , objects = Dict.fromList [
            ("Skybox", {
                  name = "Skybox"
                  , objectType = Skybox
                  , position = Vector3.default
                  , rotation = Vector3.default
                  , texture = {
                        name = "com.demensdeum.skybox"
                  }
                  , model = Model.default
                  , isMovable = False
            }),
            ("Spaceship", {
                  name = "Spaceship"
                  , objectType = Model
                  , position = {
                    x = -0.5
                    , y = 0
                    , z = -1
                  }
                  , rotation = Vector3.default
                  , texture = Texture.default
                  , model = {
                        name = "com.demensdeum.spaceship"
                  }
                  , isMovable = False
            })        
          ]
          , physicsEnabled = False
    }

step: Canvas -> Canvas
step model = 
  model     