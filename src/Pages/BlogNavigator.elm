module Pages.BlogNavigator exposing (main)

import Browser
import Ui.PageWrapper
import Elements.Nav
import Util exposing (flip)
import Html exposing (Html, div, a, h1, text, br, p, input, ul, li, button)
import Html.Attributes exposing (src, alt, height, width, href, target, class)
import Html.Events exposing (onInput)
import Html.Events exposing (onClick)

type Msg
  = OnSearch String
  | OnTagSelected Tag

type Tag = Rant | Misc

type alias BlogPost = 
  { tags: List Tag
  , href: String
  , title: String
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
  [ { title = "Initial Post"
    , href = "/initial-post"
    , tags = [ Misc ]
    }
  ]

allUniqueTags: List Tag
allUniqueTags = 
  [ Rant
  , Misc
  ]

tagToString : Tag -> String
tagToString t =
  case t of
    Rant ->
      "Rant"
    Misc ->
      "Misc"


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


isSelected : List Tag -> Tag -> Bool
isSelected = (flip List.member) 

update : Msg -> Model -> (Model, Cmd Msg) 
update msg model = 
  case msg of 
    OnSearch s ->
      ( { model | searchString = Just s } , Cmd.none)
    OnTagSelected t ->
      let
          newTags =
            if not (isSelected model.selectedTags t) then
              t :: model.selectedTags 
            else 
              List.filter ((/=) t) model.selectedTags
      in
      ( { model | selectedTags = newTags }, Cmd.none )


body: Model -> Html Msg
body model =
  let
      tagPill : Tag -> Html Msg
      tagPill t = 
        button [ onClick <| OnTagSelected t ] [ text <| tagToString t]

      tagFilter = 
        div [] (List.map tagPill allUniqueTags)


      hasSelectedTags : BlogPost -> Bool
      hasSelectedTags bp =
        case model.selectedTags of 
          [] ->
            True
          selected ->
            List.any (flip (List.member) selected ) bp.tags


      searchBar = 
        div []
          [ input [ onInput OnSearch] [ text "hello" ]
          ]

      blogPosts = 
        let
          renderBlogPost : BlogPost -> Html Msg
          renderBlogPost bp =
            div [] [ a [ href ("/blog" ++ bp.href) ] [ text bp.title ] ]

          filteredBlogPosts =
            let
               filteredByTag =  
                  allBlogPosts
                    |> List.filter (hasSelectedTags)

            in
            case model.searchString of
                Just s ->
                  filteredByTag
                    |> List.filter (.title >> String.toLower >> String.contains (String.toLower s))  
                  
                Nothing ->
                  filteredByTag
          
        in
        ul [] <| List.map renderBlogPost filteredBlogPosts
  in
  div []
  [ searchBar
  , tagFilter
  , blogPosts
  ]

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
 

