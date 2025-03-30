module Pages.Page exposing (Page)
import Html exposing (Html)
import Elements.Nav exposing (NavPage)

type alias Page msg =
  { subtitle: String
  , body: Html msg
  , page: NavPage
  }

