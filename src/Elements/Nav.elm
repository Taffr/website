module Elements.Nav exposing
  ( init
  , view
  , main
  , navPageToString
  , NavPage(..)
  )
import Browser
import Html exposing (Html)
import Html.Attributes exposing (class, classList)


type alias Model =
  { pages: List NavPage
  , selectedPage: NavPage
  }

type NavPage
  = Home
  | Blog
  | CV


type Msg = NoOp

navPageToString : NavPage -> String
navPageToString np =
  case np of
      Home ->
        "Home"
      Blog ->
        "Blog"
      CV ->
        "CV"

navPageToHref: NavPage -> String
navPageToHref np =
  case navPageToString np of
    "Blog" ->
      "blog/"
    "Home" ->
      ""
    s -> 
      s

stringToNavPage: String -> NavPage
stringToNavPage s = 
  case s of
      "Home" ->
        Home 
      "CV" ->
        CV
      _ ->
        Blog


init : String -> ( Model, Cmd Msg )
init selectedPage =
  (
    { selectedPage = stringToNavPage selectedPage
    , pages = [ Home, Blog, CV ]
    }
  , Cmd.none )


pageButton : NavPage -> NavPage -> Html msg
pageButton selectedPage page =
  let
      pageString = navPageToString page
      isSelectedPage = selectedPage == page
  in
  Html.h3
    [ classList [ ( "navbar-page-buttons--selected", isSelectedPage ) ] ] 
    [ Html.a
      [ Html.Attributes.href ("/" ++ (String.toLower <| navPageToHref page)) ]
      [ Html.text pageString ]
    ]


view : Model -> Html msg
view model = 
  let 
      renderPageButtonWithChosen = pageButton model.selectedPage
  in
  Html.div [ class "navbar" ]
    [ Html.h2 []
      [ Html.a 
        [ Html.Attributes.href ("/" ++ (String.toLower <| navPageToHref Home)) 
        ] 
        [ Html.text "Simon Tenggren" ]
      ]
    , Html.div [ class "navbar-page-buttons"] <| List.map renderPageButtonWithChosen model.pages
    ]

update: Msg -> Model -> ( Model, Cmd Msg )
update _ model = ( model, Cmd.none )

main: Program String Model Msg
main = Browser.element 
  { init = init
  , update = update
  , view = view
  , subscriptions = always Sub.none
  }
