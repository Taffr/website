module Ui.Nav exposing
  (init
  , view
  )
import Html exposing (Html)
import Html.Attributes exposing (class, style )

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

view : List (Html msg) -> NavModel -> Html msg
view children model = 
  Html.div [ class "navbar" ]
  [ Html.ul [] <| List.map (\page -> Html.li [] [ Html.text page ]) model.pages
  , Html.div [] (Debug.log "children" children)
  , Html.text "hello"
  ]
