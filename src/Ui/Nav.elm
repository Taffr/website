module Ui.Nav exposing
  ( init
  , view
  , NavPage(..)
  )
import Html exposing (Html)
import Html.Attributes exposing (class, classList)


type alias NavModel =
  { pages: List NavPage
  , selectedPage: NavPage
  }

type alias Flags =
  { selectedPage: NavPage
  }


type NavPage
  = Home
  | Blog
  | CV


navPageToString : NavPage -> String
navPageToString np =
  case np of
      Home ->
        "Home"
      Blog ->
        "Blog"
      CV ->
        "CV"


init : Flags -> NavModel
init flags =
  { selectedPage = flags.selectedPage
  , pages = [ Home, Blog, CV ]
  }


pageButton : NavPage -> NavPage -> Html msg
pageButton selectedPage page =
  let
      pageString = navPageToString page
      isSelectedPage = selectedPage == page
  in
  Html.h3
    [ classList [ ( "navbar-page-buttons--selected", isSelectedPage ) ] ] 
    [ Html.a
      [ Html.Attributes.href ("/" ++ String.toLower pageString) ]
      [ Html.text pageString ]
    ]


view : NavModel -> Html msg
view model = 
  let 
      renderPageButtonWithChosen = pageButton model.selectedPage
  in
  Html.div [ class "navbar" ]
    [ Html.h2 [] [ Html.text "Simon Tenggren"]
    , Html.div [ class "navbar-page-buttons"] <| List.map renderPageButtonWithChosen model.pages
    ]
