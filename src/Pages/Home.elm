module Pages.Home exposing (main)

import Browser
import Ui.Nav
import Html exposing (Html)

type Msg
  = NoOp

type alias Model =
  {
  }

type alias Flags =
  {
  }

init: Flags -> (Model, Cmd Msg)
init _ =
  let
    model: Model
    model = {}
  in
  (model, Cmd.none)


update : Msg -> Model -> (Model, Cmd Msg)
update _ model = (model, Cmd.none)

view: Model -> Browser.Document Msg
view _ =
  { title = "Simon Tenggren.xyz: Home Test Hello"
  , body = 
    [ Ui.Nav.init
        { pages = [ "About", "CV", "Blog" ]
        , selectedPage = Nothing
        }
        |> Ui.Nav.view
    , Html.text "Home"
    ]
  }

main: Program Flags Model Msg
main = Browser.document
    { init = init
    , view = view
    , update = update
    , subscriptions = (\_ -> Sub.none)
    }
