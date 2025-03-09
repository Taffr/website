module Pages.Home exposing (main)

import Browser
import Ui.PageWrapper
import Ui.Nav
import Ui.Separator
import Html exposing (Html, div, a, h1, text, br, p)
import Html.Attributes exposing (src, alt, height, width, href, style, target, class)
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
  let 
      lineBreak = div []
        [ br [] [] 
        ]

      icon source altText = 
        img
          [ src source
          , alt altText
          , width 48
          , height 48
          ] []

      sep : Html msg
      sep = Ui.Separator.view Ui.Separator.Horizontal

      linkIcons =
        [ a
            [ href "https://github.com/Taffr"
            ]
            [ icon "github-mark.svg" "GitHub"
            ]
        , a
            [ href "https://www.linkedin.com/in/simon-tenggren-b30b01143/"
            ]
            [ icon "icons8-linkedin.svg" "LinkedIn"
            ]
        , a
            [ href "mailto:simon.tenggren@gmail.com"
            , target "_blank"
            ]
            [ icon "email-svgrepo-com.svg" "Send me an E-Mail"
            ]
        ]


      aboutSection = div []
        [ h1 [] [ text "About" ]
        , p []
          [ text "Software Engineer with passion for Functional Programming, Software Quality, and Craftmanship."
          , lineBreak
          , text "M.Sc. in Information and Communcation Engineering Technologies"
          , lineBreak
          , text "Currently employed at PinMeTo."
          ]
        ]

      contactSection =
        div [ class "home-contact-section"] 
          [ sep
          , div [ class "home-contact-section-icons" ] linkIcons
          ]
          
  in
  div [ class "home-body" ]
    [ h1 [] [ text "Latest Blog post"]
    , a [] [ text "Link to blog post goes here" ]
    , lineBreak
    , aboutSection
    , lineBreak
    , contactSection
    ]

view: Model -> Browser.Document Msg
view _ =
  Ui.PageWrapper.wrap
    { subtitle = "Home"
    , page = Ui.Nav.Home
    , body = body
    }

main: Program Flags Model Msg
main = Browser.document
    { init = init
    , view = view
    , update = update
    , subscriptions = always Sub.none
    }
