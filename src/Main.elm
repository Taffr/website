module Main exposing (main)

import Browser
import Ui.Nav
import Url
import Browser.Navigation
import Html

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
  , body = [
      Ui.Nav.init { pages = [ "About", "CV", "Blog" ], selectedPage = Nothing }
        |> Ui.Nav.view [ Html.text "a child", Html.text "another child"]

    ]
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
