module Pages.Home_ exposing (view)

import Html
import View exposing (View)
import Ui

view : View msg
view =
    { title = "Homepage"
    , body = Ui.layout [ Html.text "Homepage" ]
    }
