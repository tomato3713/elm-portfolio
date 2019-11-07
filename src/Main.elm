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
    , url : String
    , lang : String
    , description : String
    }


type Model
    = Failure
    | Loading
    | Success String


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading
    , Http.get
        { url = "https://api.github.com/users/tomato3713/repos?sort=updated"
        , expect = Http.expectString GotText
        }
    )



-- UPDATE


type Msg
    = GotText (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotText result ->
            case result of
                Ok fullText ->
                    ( Success fullText, Cmd.none )

                Err _ ->
                    ( Failure, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    topNoMenu model


topNoMenu : Model -> Html msg
topNoMenu model =
    Html.div
        [ Attributes.id "App" ]
        [ Html.button
            []
            [ Html.text "menu" ]
        , Html.div
            [ Attributes.id "contents" ]
            [ developments model ]
        , contacts
        ]


top : Model -> Html msg
top model =
    Html.div
        [ Attributes.id "App" ]
        [ Html.button
            []
            [ Html.text "menu" ]
        , topMenu
        , Html.div
            [ Attributes.id "contents" ]
            [ developments model
            ]
        , contacts
        ]



--- top menu component


topMenu =
    Html.ul
        [ Attributes.id "top-menu", Attributes.class "menu" ]
        [ Html.li
            [ Attributes.class "menu-item" ]
            [ Html.text "test" ]
        , Html.li
            [ Attributes.class "menu-item" ]
            [ Html.text "test" ]
        ]



--- GitHub repository component


developments : Model -> Html msg
developments model =
    Html.div
        [ Attributes.class "developments" ]
        [ Html.div
            [ Attributes.class "developments-title" ]
            [ Html.text "Developments" ]
        , case model of
            Failure ->
                Html.text "I was unable to load repositories..."

            Loading ->
                Html.text "Loading..."

            Success fullText ->
                Html.pre [] [ Html.text fullText ]
        , Html.div
            [ Attributes.class "developments-item" ]
            []
        ]



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
