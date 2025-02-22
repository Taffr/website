module Ui.Nav exposing
  (init
  , view
  )
import Html exposing (Html)
import Html.Attributes exposing (class, classList)

type alias NavModel =
  { pages: List String
  , selectedPage: Maybe String
  }

type alias Flags =
  { pages: List String
  , selectedPage: Maybe String
  }

init : Flags -> NavModel
init flags =
  { selectedPage = flags.selectedPage
  , pages = flags.pages
  }

pageButton : Maybe String -> String -> Html msg
pageButton selectedPage page =
  let
     isSelectedPage = Maybe.withDefault False <| Maybe.map ((==) <| String.toLower page) (Debug.log "selected" selectedPage)
  in
  Html.h3
    [ classList [ ( "navbar-page-buttons--selected", isSelectedPage ) ] ] 
    [ Html.a
      [ Html.Attributes.href ("/" ++ String.toLower page) ]
      [ Html.text page ]
    ]

view : List (Html msg) -> NavModel -> Html msg
view children model = 
  let 
      renderPageButtonWithChosen = pageButton model.selectedPage
  in
  Html.div [ class "navbar" ]
    [ Html.h2 [] [ Html.text "Simon Tenggren"]
    , Html.div [ class "navbar-page-buttons"] <| List.map renderPageButtonWithChosen model.pages
    ]
