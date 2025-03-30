module Ui.PageWrapper exposing (wrap)
import Browser
import Elements.Nav
import Pages.Page exposing (Page)
import Html exposing (div)
import Html.Attributes exposing (class)


wrap : Page msg -> Browser.Document msg
wrap { subtitle, body, page } = 
  { title = "Simon Tenggren.xyz: " ++ subtitle
  , body =
    [ Elements.Nav.init (Elements.Nav.navPageToString page)
      |> Tuple.first
      |> Elements.Nav.view
    , div [ class "page-wrapper" ]
        [ div [ class "page-body-wrapper" ]
          [ body
          ]
        ]
    ] 
  }



