module Pages.BlogNavigator exposing (main)

import Browser
import Ui.PageWrapper
import Ui.Separator
import Elements.Nav
import Html exposing (Html, div, a, h1, text, br, p)
import Html.Attributes exposing (src, alt, height, width, href, target, class)
import Html exposing (img)

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


body: Html Msg
body =
  text "hello world"

view: Model -> Browser.Document Msg
view _ =
  Ui.PageWrapper.wrap
    { subtitle = "Blog 2"
    , page = Elements.Nav.Blog
    , body = body
    }

main: Program Flags Model Msg
main = Browser.document
    { init = init
    , view = view
    , update = update
    , subscriptions = always Sub.none
    }
 

