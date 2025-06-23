module Pages.BlogNavigator exposing (main)

import Browser
import Ui.PageWrapper
import Ui.Card as Card
import Elements.Nav
import Util exposing (flip)
import Date exposing (Date, compareDates)
import Ui.Separator
import Html exposing (Html, div, a, text, input, button)
import Html.Attributes exposing (class)
import Html.Events exposing (onInput)
import Html.Events exposing (onClick)
import Util exposing (unique)
import Html.Attributes exposing (classList)
import Html.Attributes exposing (placeholder)

type Msg
  = OnSearch String
  | OnTagSelected Tag

type Tag
  = Rant
  | Misc
  | Software
  | Quality
  | Testing
  | FunctionalProgramming
  | ProgrammingLanguage String


type alias BlogPost = 
  { tags: List Tag
  , title: String
  , date: Date
  , href: String
  , description: String
  }

type alias Model =
  { searchString: Maybe String
  , selectedTags: List Tag
  }

type alias Flags =
  {
  }

allBlogPosts : List BlogPost
allBlogPosts = 
  [ { title = "You don't need to mock; Practical Unit Testing Tips"
    , href = "/practical-unit-testing"
    , description = "A workshop on writing unit tests the easy way, now in written form."
    , tags = [ Software, Quality, Testing ]
    , date = Date.YearMonthDay 2025 1 1
    }
  , { title = "Where did my if-statements go?"
    , href = "/where-did-my-if-statements-go"
    , description = "Language agnostic error handling, inspired by functional programming concepts."
    , tags = 
      [ Software
      , FunctionalProgramming
      , ProgrammingLanguage "TypeScript"
      , ProgrammingLanguage "Go"
      ]
    , date = Date.YearMonthDay 2026 6 23
    }
  ]
  |> List.sortWith (\a b -> compareDates b.date a.date)

allUniqueTags: List Tag
allUniqueTags =
  allBlogPosts
  |> List.concatMap .tags
  |> unique (==)

tagToString : Tag -> String
tagToString t =
  case t of
    Rant ->
      "Rant"
    Misc ->
      "Misc"
    Quality ->
      "Quality"
    Testing ->
      "Testing"
    Software ->
      "Software"
    FunctionalProgramming ->
      "Functional Programming"
    ProgrammingLanguage lang ->
      lang


init: Flags -> (Model, Cmd Msg)
init _ =
  let
    model: Model
    model = 
      { searchString = Nothing
      , selectedTags = []
      }
  in
  (model, Cmd.none)


update : Msg -> Model -> (Model, Cmd Msg) 
update msg model = 
  case msg of 
    OnSearch s ->
      ( { model | searchString = Just s } , Cmd.none)
    OnTagSelected t ->
      let
          newTags = 
            if List.member t model.selectedTags then
              List.filter ((/=) t) model.selectedTags
            else 
              t :: model.selectedTags
      in
      ( { model | selectedTags = newTags }, Cmd.none )


body: Model -> Html Msg
body model =
  let
      isSelected = (flip (List.member)) model.selectedTags

      tagPill t = 
        button 
          [ OnTagSelected t |> onClick 
          , classList 
            [ ( "blog-tag-filter-button-selected", isSelected t )
            , ( "blog-tag-filter-button", True )
            ]
          ]
          [ t |> tagToString |> text ]

      tagFilter = 
        div [ class "blog-tag-filter-button-container" ] <| List.map tagPill allUniqueTags


      hasSelectedTags : BlogPost -> Bool
      hasSelectedTags bp =
        case model.selectedTags of 
          [] ->
            True
          selected ->
            List.any (flip (List.member) selected ) bp.tags


      searchBar = 
        div 
          [ class "search-bar-container"
          ]
          [ input 
            [ class "search-bar"
            , placeholder "Search..."
            , onInput OnSearch
            ] []
          ]


      blogPosts = 
        let
          tag : Tag -> Html Msg
          tag t = 
            button 
            [ class "blog-tag-filter-button"
            ]
            [ text <| tagToString t ]

          renderBlogPost : BlogPost -> Html Msg
          renderBlogPost bp =
            let
              info = 
                { title = bp.title
                , description = bp.description
                , date = bp.date
                , tags = bp.tags
                , tagFormatter = tag
                , link = Just ("/blog" ++ bp.href)
                }
            in
              Card.view info

          filteredBlogPosts =
            let
               filteredByTag =  
                  allBlogPosts
                    |> List.filter (hasSelectedTags)

               filterBySearchTerm s =
                  List.filter (.title >> String.toLower >> String.contains (String.toLower s))
            in
            case model.searchString of
                Just searchTerm ->
                  filteredByTag
                    |> filterBySearchTerm searchTerm
                  
                Nothing ->
                  filteredByTag
          
        in
        List.map renderBlogPost filteredBlogPosts

      filter: Html Msg
      filter = div [ class "blog-filter-container"]
        [ searchBar
        , tagFilter
        , Ui.Separator.view Ui.Separator.Horizontal
        ]
  in
  div [ class "blog-container" ] <| filter :: blogPosts

view: Model -> Browser.Document Msg
view model =
  Ui.PageWrapper.wrap
    { subtitle = "Blog"
    , page = Elements.Nav.Blog
    , body = body model
    }

main: Program Flags Model Msg
main = Browser.document
    { init = init
    , view = view
    , update = update
    , subscriptions = always Sub.none
    }
 

