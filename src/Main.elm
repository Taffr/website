module Main exposing (main)

import Browser
import Html
import Html.Attributes exposing (class)


view _ =
  Html.div [ class "container mt-5" ] [ Html.text "Hello Elm!" ]


main = Browser.sandbox
    { init = ()
    , update = \_ _ -> ()
    , view = view
    }
