module Elements.RepoList exposing
  ( main
  )
import Ui.Card as Card
import Browser
import Date exposing (dateFromString)
import Html exposing (Html)
import Http
import Html.Attributes exposing (class, classList)
import Json.Decode exposing (Decoder, int, string, field, map7, list)
import Json.Decode exposing (nullable)
import Json.Decode exposing (maybe)
import List exposing (sort)
import List exposing (sortBy)
import List exposing (reverse)


type alias Model =
  { repos: Maybe (List Repo)
  }


type alias Flags =
  {
  }


type alias Repo = 
  { id: Int
  , name: String
  , description: Maybe String
  , url: String
  , language: Maybe String
  , createdAt: String
  , updatedAt: String
  }


repoDecoder : Decoder Repo
repoDecoder = 
  map7 Repo
    (field "id" int)
    (field "name" string)
    (maybe (field "description" (string)))
    (field "html_url" string)
    (maybe (field "language" (string)))
    (field "created_at" string)
    (field "updated_at" string)
   

url: String
url = "https://api.github.com/users/Taffr/repos"


fetchRepos : Cmd Msg
fetchRepos = 
  Http.get 
    { url = url
    , expect = Http.expectJson (OnReposReceived) (list repoDecoder)
    }

type Msg = OnReposReceived (Result Http.Error (List Repo))

init : Flags -> ( Model, Cmd Msg )
init _ =
  ( { repos = Nothing }, fetchRepos )


view : Model -> Html msg
view model = 
  let
      defaultDate = Date.YearMonthDay 1970 1 1 
      repoToCardInfo repo =
        { title = repo.name
        , date = (dateFromString repo.updatedAt |> Result.withDefault defaultDate)
        , description = repo.description |> Maybe.withDefault "" 
        , tags = [ repo.language ]
        , tagFormatter = Maybe.withDefault "" >> Html.text >> (\c -> Html.p [ class "card-date" ] [ c ])
        , link = Just (repo.url)
        }

      cards = 
        model.repos
        |> Maybe.map (List.take 5)
        |> Maybe.map (List.map (repoToCardInfo >> Card.view)) 
        |> Maybe.withDefault []
  in
  case cards of
      [] ->
        Html.text ""
      loadedCards ->
        Html.div [] ((Html.h1 [] [ Html.text "Latest Updated Repositories" ]) :: loadedCards)


update: Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
  case msg of 
    OnReposReceived (Err _) ->
      ( { model | repos = Nothing }, Cmd.none )
    OnReposReceived (Ok repos) ->
      let
          sorted = sortBy (.updatedAt) repos |> reverse
      in
      ( { model | repos = Just sorted }, Cmd.none )


main: Program Flags Model Msg
main = Browser.element 
  { init = init
  , update = update
  , view = view
  , subscriptions = always Sub.none
  }
