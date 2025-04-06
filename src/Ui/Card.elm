module Ui.Card exposing (view)
import Html exposing (Html, a, div, p, h3, text )
import Html.Attributes exposing (class, href)
import Date exposing (Date, dateToString)
import Ui.Separator

type alias CardInfo a msg = 
  { title: String
  , date: Date
  , description: String
  , link: Maybe String
  , tags: List a
  , tagFormatter: a -> Html msg
  }


view : CardInfo a msg -> Html msg
view { date, title, tags, description, tagFormatter, link } = 
  let
    body =   
      div [ class "card" ] 
        [ div [ class "card-content" ]
          [ p [ class "card-date" ] [ text <| dateToString date ]
          , h3 [ class "card-link with-decor"] [ text title ]
          , p [] [ text description ]
          , Ui.Separator.view Ui.Separator.Horizontal
          , div [ class "card-tag-container" ] (List.map tagFormatter tags)
          ]
        ]
  in
  case link of 
    Nothing ->
      body
    Just l ->
      a [ class "card-link", href l] [ body ]
