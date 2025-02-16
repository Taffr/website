module Main exposing (main)

import Browser
import Html exposing (Html)
import Html.Attributes exposing (class, href, type_)
import Url
import Browser.Navigation
import Browser
import Bootstrap.Modal exposing (body)

type Msg = NoOp
type alias Model = {}

type alias Flags =
  {

  }
init: Flags -> Url.Url -> Browser.Navigation.Key -> (Model, Cmd msg)
init _ _ _ = ( {}, Cmd.none )


update : msg -> Model -> (Model, Cmd msg)
update _ model = ( model, Cmd.none )

view: Model -> Browser.Document msg
view _ =
  { title = "Simon Tenggren.xyz"
  , body = [ Html.text "Hello Elm!" ]
  }

main : Program Flags Model (Cmd msg)
main = Browser.application
    { init = init
    , update = update
    , view = view
    , onUrlChange = (\_ ->  Cmd.none)
    , onUrlRequest = (\_ ->  Cmd.none)
    , subscriptions = (\_ -> Sub.none)
    }
