module Pages.CV exposing (main)

import Browser
import Ui.PageWrapper
import Ui.Nav
import Ui.Separator
import Html exposing (Html, div, a, h1, text, br, p, object)
import Html.Attributes exposing (src, alt, height, width, href, style, target, class, attribute, type_)
import Html exposing (img)


type Msg = NoOp

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

body: Model -> Html Msg
body _ = 
  let 
      cvPdfSection : Html msg
      cvPdfSection = object 
        [ type_ "application/pdf"
        , attribute "data" "CV_Q1_2024.pdf"
        , width 1300
        , height 1100
        ]
        []
  in
  div [ class "cv-body" ]
    [ cvPdfSection
    ]


view: Model -> Browser.Document Msg
view m =
  Ui.PageWrapper.wrap
    { subtitle = "CV"
    , page = Ui.Nav.CV
    , body = body m
    }

main: Program Flags Model Msg
main = Browser.document
    { init = init
    , view = view
    , update = update
    , subscriptions = always Sub.none
    }
