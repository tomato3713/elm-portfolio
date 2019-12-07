module Main exposing (GitHubRepo, Model, Msg(..), State(..), contacts, developments, init, main, reposDecoder, subscriptions, topMenu, update, view, viewRepositories)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events
import Http
import Json.Decode
import List
import Url


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL


type alias GitHubRepo =
    { name : String
    , html_url : String
    }


type State
    = Failure
    | Loading
    | Success (List GitHubRepo)


type alias Model =
    { state : State
    , menuFlag : Bool
    , key : Nav.Key
    , url : Url.Url
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( { state = Loading
      , menuFlag = False
      , key = key
      , url = url
      }
    , Http.get
        { url = "https://api.github.com/users/tomato3713/repos?sort=updated&per_page=5"
        , expect = Http.expectJson GotRepositories reposDecoder
        }
    )


reposDecoder : Json.Decode.Decoder (List GitHubRepo)
reposDecoder =
    Json.Decode.map2 GitHubRepo
        (Json.Decode.field "name" Json.Decode.string)
        (Json.Decode.field "html_url" Json.Decode.string)
        |> Json.Decode.list



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | GotRepositories (Result Http.Error (List GitHubRepo))
    | ShowMenu
    | HideMenu


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )

        GotRepositories resul ->
            Debug.log "" resul
                |> (\result ->
                        case result of
                            Ok fullRepos ->
                                ( { model | menuFlag = model.menuFlag, state = Success fullRepos }, Cmd.none )

                            Err _ ->
                                ( { model | menuFlag = model.menuFlag, state = Failure }, Cmd.none )
                   )

        ShowMenu ->
            ( { model | menuFlag = True, state = model.state }, Cmd.none )

        HideMenu ->
            ( { model | menuFlag = False, state = model.state }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "tomato3713's site"
    , body =
        [ Html.div
            [ Attributes.id "App" ]
            [ Html.button
                [ if model.menuFlag then
                    Events.onClick HideMenu

                  else
                    Events.onClick ShowMenu
                ]
                [ Html.text "menu" ]
            , Html.div []
                [ topMenu model ]
            , Html.div
                [ Attributes.id "contents" ]
                [ developments model ]
            , contacts
            ]
        ]
    }



--- top menu component


topMenu : Model -> Html msg
topMenu model =
    Html.ul
        [ Attributes.id "top-menu"
        , Attributes.class "menu"
        ]
        [ if model.menuFlag then
            Html.div
                []
                [ Html.li
                    [ Attributes.class "menu-item"
                    ]
                    [ Html.a
                        [ Attributes.href "/" ]
                        [ Html.text "Home" ]
                    ]
                , Html.li
                    [ Attributes.class "menu-item"
                    ]
                    [ Html.a
                        [ Attributes.href "https://tomato3713.hatenablog.com/" ]
                        [ Html.text "Blog" ]
                    ]
                , Html.li
                    [ Attributes.class "menu-item" ]
                    [ Html.a
                        [ Attributes.href "/links" ]
                        [ Html.text "Links" ]
                    ]
                , Html.li
                    [ Attributes.class "menu-item"
                    , Attributes.style "float" "right"
                    ]
                    [ Html.a
                        [ Attributes.href "/about" ]
                        [ Html.text "About" ]
                    ]
                ]

          else
            Html.span
                []
                []
        ]



--- GitHub repository component


developments : Model -> Html msg
developments model =
    Html.div
        [ Attributes.class "developments" ]
        [ Html.div
            [ Attributes.class "developments-title" ]
            [ Html.text "Developments" ]
        , case model.state of
            Failure ->
                Html.text "I was unable to load repositories..."

            Loading ->
                Html.text "Loading..."

            Success fullRepos ->
                viewRepositories fullRepos
        , Html.div
            [ Attributes.class "developments-item" ]
            []
        ]


viewRepositories : List GitHubRepo -> Html msg
viewRepositories repos =
    repos
        |> List.map (\l -> Html.li [] [ Html.text l.name ])
        |> Html.ul []



--- Contacts component


contacts : Html msg
contacts =
    Html.div
        [ Attributes.class "contacts" ]
        [ Html.div
            [ Attributes.class "contacts-title" ]
            [ Html.text "Contacts" ]
        , Html.ul
            []
            [ Html.li
                []
                [ Html.span
                    []
                    [ Html.a
                        [ Attributes.href "https://twitter.com/tomato3713", Attributes.class "contacts-item" ]
                        [ Html.text "Twitter: @tomato3713" ]
                    ]
                ]
            , Html.li
                []
                [ Html.span
                    []
                    [ Html.a
                        [ Attributes.href "https://github.com/tomato3713", Attributes.class "contacts-item" ]
                        [ Html.text "GitHub: @tomato3713" ]
                    ]
                ]
            , Html.li
                []
                [ Html.span
                    []
                    [ Html.a
                        [ Attributes.href "https://tomato3713.hatenablog.com/", Attributes.class "contacts-item" ]
                        [ Html.text "Blog (はてなブログ)" ]
                    ]
                ]
            , Html.li
                []
                [ Html.span
                    []
                    [ Html.a
                        [ Attributes.href "https://qiita.com/tomato3713", Attributes.class "contacts-item" ]
                        [ Html.text "Qiita MyPage" ]
                    ]
                ]
            , Html.li
                []
                [ Html.span
                    [ Attributes.class "contacts-item" ]
                    [ Html.text "Mail: " ]
                ]
            ]
        ]
