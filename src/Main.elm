module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events
import Http
import Json.Decode


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias GitHubRepo =
    { name : String
    , html_url : String
    , language : String
    , description : String
    }


type State
    = Failure
    | Loading
    | Success (List GitHubRepo)


type alias Model =
    { state : State
    , menuFlag : Bool
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { state = Loading, menuFlag = False }
    , Http.get
        { url = "https://api.github.com/users/tomato3713/repos?sort=updated"
        , expect = Http.expectJson GotRepositories reposDecoder
        }
    )


reposDecoder : Json.Decode.Decoder (List GitHubRepo)
reposDecoder =
    Json.Decode.map4 GitHubRepo
        (Json.Decode.field "name" Json.Decode.string)
        (Json.Decode.field "html_url" Json.Decode.string)
        (Json.Decode.field "language" Json.Decode.string)
        (Json.Decode.field "description" Json.Decode.string)
        |> Json.Decode.list



-- UPDATE


type Msg
    = GotRepositories (Result Http.Error (List GitHubRepo))
    | ShowMenu
    | HideMenu


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotRepositories result ->
            case result of
                Ok fullRepos ->
                    ( { state = Success fullRepos, menuFlag = model.menuFlag }, Cmd.none )

                Err _ ->
                    ( { state = Failure, menuFlag = model.menuFlag }, Cmd.none )

        ShowMenu ->
            ( { state = model.state, menuFlag = True }, Cmd.none )

        HideMenu ->
            ( { state = model.state, menuFlag = False }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    top model


top : Model -> Html Msg
top model =
    Html.div
        [ Attributes.id "App" ]
        [ if model.menuFlag then
            Html.div
                []
                [ Html.button
                    [ Events.onClick HideMenu ]
                    [ Html.text "Close Menu" ]
                , Html.div
                    []
                    [ topMenu model ]
                ]

          else
            Html.button
                [ Events.onClick ShowMenu ]
                [ Html.text "Open menu" ]
        , Html.div
            [ Attributes.id "contents" ]
            [ developments model ]
        , contacts
        ]



--- top menu component


topMenu : Model -> Html msg
topMenu model =
    Html.ul
        [ Attributes.id "top-menu", Attributes.class "menu" ]
        [ case model.menuFlag of
            True ->
                Html.div []
                    [ Html.li
                        [ Attributes.class "menu-item" ]
                        [ Html.text "menu1" ]
                    , Html.li
                        [ Attributes.class "menu-item" ]
                        [ Html.text "menu2" ]
                    ]

            False ->
                Html.text "no menu"
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
