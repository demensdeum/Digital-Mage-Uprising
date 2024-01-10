port module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Process exposing (..)
import Task exposing (..)
import Shared.Scene exposing (..)

-- States

import States.Idle exposing (..)
import States.CompanyLogo exposing (..)
import States.MainMenu exposing (..)
import States.InGame exposing (..)
import States.InGame as InGame
import States.Idle as Idle

import Json.Decode as Decode

import CustomControls exposing (threeCanvas)

import Dict exposing (..)

import Shared.Canvas exposing (..)
import Shared.Canvas as Canvas
import States.CompanyLogo as CompanyLogo

import Time exposing (every, Posix, now, posixToMillis)
import Platform.Cmd as Cmd
import States.MainMenu as MainMenu

-- PORTS

port buttonPressedReceiver: (String -> msg) -> Sub msg
port websocketsConnected: (String -> msg) -> Sub msg
port sendCanvas : String -> Cmd msg
port nativeCanvasReceiver : (String -> msg) -> Sub msg
port serverCanvasReceiver: (String -> msg) -> Sub msg
port connectionError: (String -> msg) -> Sub msg

type alias Context =
  {
    initialSeed: Int
    , state : State
    , canvas: Canvas
  }

type State = 
  Idle States.Idle.Substate
  | CompanyLogo CompanyLogo.Substate
  | MainMenu States.MainMenu.Substate
  | InGame InGame.Substate

-- MAIN

main : Program () Context EngineMessage
main =
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

subscriptions : Context -> Sub EngineMessage
subscriptions _ =
  Sub.batch
        [ nativeCanvasReceiver ReceiveNativeCanvas
        , serverCanvasReceiver ReceiveServerCanvas
        , buttonPressedReceiver ButtonPressed
        , every 30 SendCanvas
        ]

init : () -> ( Context, Cmd EngineMessage )
init _ =
    ({
      initialSeed = 0
      , state = Idle Idle.initialSubstate
      , canvas = Idle.initialCanvas
    }
    , Cmd.batch 
    [ Task.perform UpdateTimestamp now
    ]
    )

-- UPDATE

type EngineMessage
  = WebsocketConnectionInitialized String
  | ButtonPressed String
  | ReceiveNativeCanvas String
  | ReceiveServerCanvas String
  | UpdateTimestamp Posix
  | SendCanvas Posix
  | ConnectionError
  | Step Float

initialGameContext: Int -> Context
initialGameContext seed =
  {
    initialSeed = seed
    , state = CompanyLogo CompanyLogo.initialSubstate
    , canvas = CompanyLogo.initialCanvas
  }

update : EngineMessage -> Context -> (Context, Cmd EngineMessage)
update msg context =
  case msg of
  UpdateTimestamp posix ->
      (initialGameContext <| posixToMillis posix, Cmd.none)

  WebsocketConnectionInitialized message ->
      (context, Cmd.none)

  ButtonPressed name ->
    case context.state of
      Idle substate ->
        (context, Cmd.none)
      CompanyLogo substate ->
        (context, Cmd.none)
      MainMenu substate ->
        let newSubstate = {substate | pressedButtonName = name} in
        ({context | state = MainMenu newSubstate} , Cmd.none)
      InGame substate ->
        (context, Cmd.none)

  ReceiveNativeCanvas canvasJsonString ->
    case Decode.decodeString Canvas.canvasFromJsonString canvasJsonString of
      Ok importedCanvas ->
        let newContext = {context | canvas = importedCanvas } in
           (step newContext, Cmd.none)    

      Err error ->
        let canvas = context.canvas in
          let newCanvasState = {canvas | message = "Canvas state parsing fail:" ++ Decode.errorToString error} in
            ({context | canvas = newCanvasState}, Cmd.none)    

  ReceiveServerCanvas serverCanvasStateJsonString ->
    case Decode.decodeString Canvas.serverCanvasFromJsonString serverCanvasStateJsonString of
      Ok serverCanvas ->
        case context.state of
          Idle substate ->
            (context, Cmd.none)
          CompanyLogo substate ->
            (context, Cmd.none)
          MainMenu substate ->
            (context, Cmd.none)
          InGame substate ->
            let newCanvas = InGame.handleServerCanvas context.canvas serverCanvas in
            ({context | canvas = newCanvas}, Cmd.none)

      Err error ->
        let canvas = context.canvas in
          let newCanvasState = {canvas | message = "Canvas state parsing fail:" ++ Decode.errorToString error} in
            ({context | canvas = newCanvasState}, Cmd.none)

  SendCanvas posix ->
    case context.state of
      Idle substate ->
        (context, Cmd.none)
      CompanyLogo substate ->
        (context, Cmd.none)
      MainMenu substate ->
        (context, Cmd.none)
      InGame substate ->
        (context, sendCanvas <| InGame.sendCanvas context.canvas substate)

  ConnectionError ->
      (context, Cmd.none)

  Step _ ->
      (step context, Cmd.none)

step: Context -> Context
step context =
  let canvas = context.canvas in
  case context.state of
    Idle substate ->
      let newCanvas = States.Idle.step canvas in
        { context | canvas = newCanvas}

    CompanyLogo substate ->
        case States.CompanyLogo.step canvas substate of
          Rendering newSubstate ->
            { context | state = CompanyLogo newSubstate}
          GoToMainMenu ->
            { context | state = MainMenu MainMenu.initialSubstate , canvas = MainMenu.initialCanvas }

    MainMenu substate ->
        case States.MainMenu.step canvas substate of
          MainMenu.Idle ->
            context
          StartNewGame ->
            { context | state = InGame InGame.initialSubstate, canvas = InGame.initialCanvas context.initialSeed }

    InGame substate ->
        case States.InGame.step canvas substate of
          Update newCanvas ->
            { context | canvas = newCanvas}

-- VIEW

view : Context -> Html EngineMessage
view context =
  threeCanvas <| Shared.Canvas.jsonStringFromCanvas context.canvas
