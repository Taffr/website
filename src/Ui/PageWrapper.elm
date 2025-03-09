module Ui.PageWrapper exposing (wrap)
import Browser
import Ui.Nav
import Pages.Page exposing (Page)
import Html exposing (div)
import Html.Attributes exposing (class)


wrap : Page msg -> Browser.Document msg
wrap { subtitle, body, page } = 
  { title = "Simon Tenggren.xyz: " ++ subtitle
  , body =
    [ Ui.Nav.init { selectedPage = page }
      |> Ui.Nav.view
    , div [ class "page-wrapper" ]
        [ div [ class "page-body-wrapper" ]
          [ body
          ]
        ]
    ] 
  }



