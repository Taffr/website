module Pages.About exposing (..)

import Browser
import Html exposing (div, h1, text, button)
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

view : Model -> Browser.Document Msg
view model = 
  { title = "About"
  , body =
    [ div []
        [ button [ Events.onClick (StartCounter)] [ text "Start counter" ]
        , h1 [] [ text (String.fromInt model.counter) ]
        , h1 [] [ text (if model.hasClicked then "Clicked" else "") ]
        , button [ Events.onClick (StopCounter)] [ text "Stop Counter" ]
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

init: Flags -> (Model, Cmd Msg)
init _ =
  ( { counter = 0 , hasClicked = False }, Cmd.none ) 

main: Program Flags Model Msg
main = Browser.document
    { init = init
    , view = view
    , update = update
    , subscriptions = (\_ -> Sub.none)
    }
