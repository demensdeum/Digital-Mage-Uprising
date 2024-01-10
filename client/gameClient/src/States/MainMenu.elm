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
            })            
          ]
        , physicsEnabled = False
      }

step: Canvas -> Canvas
step model = 
  model     