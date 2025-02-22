module Pages.About exposing (..)

import Browser
import Html exposing (Html, div, h1, text, button)
import Html.Attributes
import Html.Events as Events
import Task
import Process

type Msg
  = StartCounter
  | StopCounter
  | Increment
  | NoOp

type alias Model =
  { counter: Int
  , hasClicked: Bool
  }

type alias Flags =
  {
  }

view : (Msg -> msg) -> Model -> Browser.Document msg
view tagger model = 
  { title = "About"
  , body =
    [ div []
        [ button [ Events.onClick (tagger StartCounter)] [ text "Start counter" ]
        , h1 [] [ text (String.fromInt model.counter) ]
        , h1 [] [ text (if model.hasClicked then "Clicked" else "") ]
        , button [ Events.onClick (tagger StopCounter)] [ text "Stop Counter" ]
        ]
    ]
  }


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    StartCounter ->
      ({ model | hasClicked = True }, Task.perform (\_ -> Increment) (Process.sleep 1000))
    StopCounter ->
      ({ model | hasClicked = False, counter = 0 }, Cmd.none)
    Increment ->
      ({ model | counter = model.counter + 1 }, Task.perform (\_ -> if model.hasClicked then Increment else NoOp) (Process.sleep 1000))
    NoOp ->
      (model, Cmd.none)

init: Flags -> Model
init _ =
  { counter = 0
  , hasClicked = False
  }

