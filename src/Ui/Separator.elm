module Ui.Separator exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (classList)


type Direction 
  = Vertical
  | Horizontal


view : Direction -> Html msg
view dir = 
  div
    [ classList
      [ ( "ui-separator-vertical", dir == Vertical )
      , ( "ui-separator-horizontal", dir == Horizontal )
      ]
    ]
    []
