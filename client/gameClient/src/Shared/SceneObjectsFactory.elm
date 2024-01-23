module Shared.SceneObjectsFactory exposing (..)

import Shared.SceneObject exposing (..)
import Shared.Vector3 as Vector3
import Shared.Model as Model
import Shared.Controls as Controls

skybox: String -> String -> SceneObject
skybox name textureName =
    {
        name = name
        , position = Vector3.default
        , rotation = Vector3.default
        , objectType = Shared.SceneObject.Skybox
        , texture = {
            name = textureName
        }
        , model = Model.default
        , isMovable = False
        , controls = Controls.default
    }