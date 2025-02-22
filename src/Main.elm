module Main exposing (main)

import Browser
import Ui.Nav
import Url
import Browser.Navigation
import Html
import Url.Parser exposing (Parser, s, string, (</>))
import Url.Parser as Parser

type Msg
  = OnUrlRequest Browser.UrlRequest
  | OnUrlChange Url.Url

type Page
  = About
  | CV
  | Blog
  | BlogPost String
  | NotFound

type alias Model =
  { page: Page
  , key: Browser.Navigation.Key
  }

type alias Flags =
  {
  }

init: Flags -> Url.Url -> Browser.Navigation.Key -> (Model, Cmd Msg)
init _ url key =
  ( { page = parseUrl url, key = key }, Cmd.none )


parser : Parser (Page -> a) a
parser =
  Parser.oneOf
    [ Parser.map BlogPost (s "blog" </> string)
    , Parser.map About (s "about")
    , Parser.map Blog (s "blog")
    , Parser.map CV (s "cv")
    ]

parseUrl : Url.Url -> Page
parseUrl url = 
  case (Parser.parse parser url) of
    Just page ->
      page
    Nothing ->
      NotFound

tryPageToString : Page -> Maybe String
tryPageToString page =
  case page of
    BlogPost _ ->
      Just "blog"
    Blog ->
      Just "blog"
    CV ->
      Just "cv"
    About ->
      Just "about"
    _ ->
      Nothing


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    OnUrlChange newUrl ->
      ( { model | page = parseUrl newUrl } , Cmd.none)
    OnUrlRequest request ->
      case request of
        Browser.External href ->
          ( model, Browser.Navigation.load href )
        Browser.Internal url ->
          ( model, Browser.Navigation.pushUrl model.key (Url.toString url))

view: Model -> Browser.Document Msg
view model =
  { title = "Simon Tenggren.xyz"
  , body = [
      Ui.Nav.init { pages = [ "About", "CV", "Blog" ], selectedPage = tryPageToString model.page }
        |> Ui.Nav.view [ Html.text "a child", Html.text "another child"]
    ]
  }

main : Program Flags Model Msg
main = Browser.application
    { init = init
    , update = update
    , view = view
    , onUrlChange = OnUrlChange
    , onUrlRequest = OnUrlRequest
    , subscriptions = (\_ -> Sub.none)
    }
