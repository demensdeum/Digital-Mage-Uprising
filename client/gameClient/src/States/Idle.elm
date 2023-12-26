module States.Idle exposing (..)

import Shared.Canvas exposing (..)
import Shared.Canvas as Canvas

type alias Substate =
      {
      }

initialSubstate: Substate
initialSubstate = 
      {
      }

initialCanvas: Canvas
initialCanvas = 
      Canvas.default "Udod"

step: Canvas -> Canvas
step model =
  model