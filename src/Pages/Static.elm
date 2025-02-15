module Pages.Static exposing (view)

import Html as Html
import View exposing (View)
import Ui.Layout exposing (layout)

view : View msg
view =
  { title = "Static"
  , body = layout [ Html.text "Static" ]
  }

