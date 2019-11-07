module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events
import Http
import Json.Decode


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias GitHubRepo =
    { name : String
    , url : String
    , lang : String
    , description : String
    }


type alias Model =
    { flagMenu : Bool }


init : Model
init =
    Model False



-- UPDATE


type Msg
    = ShowMenu
    | CloseMenu


update : Msg -> Model -> Model
update msg model =
    case msg of
        ShowMenu ->
            { model | flagMenu = True }

        CloseMenu ->
            { model | flagMenu = False }



-- VIEW


view : Model -> Html Msg
view model =
    if model.flagMenu then
        top

    else
        topNoMenu



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


developments =
    Html.div
        [ Attributes.class "developments" ]
        [ Html.div
            [ Attributes.class "developments-title" ]
            [ Html.text "Developments" ]
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


topNoMenu =
    Html.div
        [ Attributes.id "App" ]
        [ Html.button
            [ Events.onClick ShowMenu ]
            [ Html.text "menu" ]
        , Html.div
            [ Attributes.id "contents" ]
            [ developments
            , Html.div
                []
                []
            , Html.div
                []
                []
            ]
        , contacts
        ]


top =
    Html.div
        [ Attributes.id "App" ]
        [ Html.button
            [ Events.onClick CloseMenu ]
            [ Html.text "menu" ]
        , topMenu
        , Html.div
            [ Attributes.id "contents" ]
            [ developments
            , Html.div
                []
                []
            , Html.div
                []
                []
            ]
        , contacts
        ]
