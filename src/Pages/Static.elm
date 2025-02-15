module Pages.Static exposing (view)

import Html as Html
import Html.Attributes as Attr
import View exposing (View)
import Ui as Ui


render: List (Html.Html msg)
render =
  [ Html.div [ Attr.class "container mt-5" ]
    [ Html.text "hello, in bootstrap"
    ]
  ]

view : View msg
view =
  { title = "Static"
  , body = Ui.layout render
  }

