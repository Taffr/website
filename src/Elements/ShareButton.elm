port module Elements.ShareButton exposing ( init, main )
import Browser
import Html exposing (Html)
import Html.Events exposing (onClick)
import Html.Attributes exposing (classList)

port out_copyToClipboard : String -> Cmd msg

type alias Model =
  { linkToShare: String
  , hasCopied: Bool
  }


type Msg = 
  OnClick

init : String -> ( Model, Cmd Msg )
init linkToShare =
  (
    { linkToShare = linkToShare
    , hasCopied = False
    }
  , Cmd.none )



view : Model -> Html Msg
view { hasCopied } = 
  let
      content = 
        if hasCopied then 
          "Copied to clipboard ✓" 
        else 
          "Share this post ↪"
  in 
  Html.button 
    [ classList 
      [ ( "blog-tag-filter-button-selected", hasCopied )
      , ( "blog-tag-filter-button", True )
      ]
    , onClick OnClick 
    ] 
    [ Html.text content
    ]

update: Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
  case msg of
      OnClick -> 
        ( { model | hasCopied = True }
        , out_copyToClipboard ("https://simontenggren.xyz" ++ model.linkToShare)
        )

main: Program String Model Msg
main = Browser.element 
  { init = init
  , update = update
  , view = view
  , subscriptions = always Sub.none
  }
