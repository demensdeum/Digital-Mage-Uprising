module CustomControls exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

-- Use the Custom Elements
--
threeCanvas : String -> Html msg
threeCanvas sceneJson =
  node "three-canvas" 
    [
      attribute "scene-json" sceneJson     
    ]
    []
