module Portfolio.Page.Top exposing (Model, Msg, Route, page, route)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key, load, pushUrl)
import Html
import Html.Attributes
import Http
import Json.Decode
import Maybe exposing (Maybe(..))
import Portfolio.Common
import Portfolio.Root as Root exposing (Flags, Session)
import Url exposing (Url)
import Url.Parser


type alias GitHubRepo =
    { name : String
    , html_url : String
    , language : Maybe String
    , description : Maybe String
    }


type Msg
    = UrlRequest UrlRequest
    | GotRepositories (Result Http.Error (List GitHubRepo))


type State
    = Failure
    | Loading
    | Success (List GitHubRepo)


type alias Model =
    { session : Session
    , key : Key
    , state : State
    }


type alias Route =
    ()


route : Url.Parser.Parser (Route -> a) a
route =
    Url.Parser.map () Url.Parser.top


init : Flags -> Url -> Key -> Route -> Maybe Session -> ( Model, Cmd Msg )
init _ _ key _ session =
    ( { session = Maybe.withDefault Root.initial session
      , key = key
      , state = Loading
      }
    , Http.get
        { url = "https://api.github.com/users/tomato3713/repos?sort=updated&per_page=5"
        , expect = Http.expectJson GotRepositories reposDecoder
        }
    )


reposDecoder : Json.Decode.Decoder (List GitHubRepo)
reposDecoder =
    Json.Decode.map4 GitHubRepo
        (Json.Decode.field
            "name"
            Json.Decode.string
        )
        (Json.Decode.field
            "html_url"
            Json.Decode.string
        )
        (Json.Decode.maybe
            (Json.Decode.field
                "language"
                Json.Decode.string
            )
        )
        (Json.Decode.maybe
            (Json.Decode.field
                "description"
                Json.Decode.string
            )
        )
        |> Json.Decode.list


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlRequest urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model, pushUrl model.key (Url.toString url) )

                External url ->
                    ( model, load url )

        GotRepositories result ->
            case result of
                Ok fullRepos ->
                    ( { session = model.session
                      , key = model.key
                      , state = Success fullRepos
                      }
                    , Cmd.none
                    )

                Err _ ->
                    ( { session = model.session
                      , key = model.key
                      , state = Failure
                      }
                    , Cmd.none
                    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Document Msg
view model =
    { title = "tomato - Home"
    , body =
        [ Portfolio.Common.header "Home"
        , Html.img
            [ Html.Attributes.class "top-header-image"
            , Html.Attributes.src "./top.jpg"
            ]
            []
        , Html.div
            [ Html.Attributes.class "contents" ]
            [ aboutSite
            , selfIntroduction
            , developments model
            ]
        , Portfolio.Common.footer
        ]
    }


aboutSite : Html.Html msg
aboutSite =
    Html.div
        [ Html.Attributes.class "about-site" ]
        [ Html.h1
            []
            [ Html.text "About Site" ]
        , Html.text "ここは、とまと ("
        , Portfolio.Common.link
            "https://twitter.com/tomato3713"
            "@tomato3713"
        , Html.text ") のポートフォリオサイトです。このWebサイトは、Elm製のSPAジェネレータである"
        , Portfolio.Common.link "https://github.com/aratama/alchelmy" "Alchelmly"
        , Html.text "を利用して作成されています"
        , Html.text "どうぞ、お茶でも飲みながらゆったりとご覧くださいませ。"
        ]


selfIntroduction : Html.Html msg
selfIntroduction =
    Html.div
        [ Html.Attributes.class "self-introduction"
        ]
        [ Html.h1
            []
            [ Html.text "Self Introduction" ]
        , Html.div
            []
            [ Html.dl
                [ Html.Attributes.class "definition_list" ]
                [ Portfolio.Common.definitionItem
                    "Name"
                    "Taichi Watanabe"
                , Portfolio.Common.definitionItem
                    "Programming Languages"
                    "Go, Java, Ruby, Python, JavaScript, CSS, Elm, C#, Lisp"
                , Portfolio.Common.definitionItem
                    "Experience"
                    "HP development, Wordpress, dotNet, API Client Library, Server Monitoring (Mackerel)"
                , Portfolio.Common.definitionItem
                    "Works (Part time jobs)"
                    "現在は、WEBSYS (社会人向けIT教育プログラム) のスタッフをしています。また、趣味としてGo言語を中心に用いたOSS開発を行っています。"
                , Portfolio.Common.definitionItem
                    "Interests"
                    "Software Engineering, Server Monitoring, Virtual Reality"
                , Portfolio.Common.definitionItem
                    "Hobby"
                    "Programming, Camera etc"
                ]
            ]
        ]



--- GitHub repository component


viewRepositories : List GitHubRepo -> Html.Html msg
viewRepositories repos =
    repos
        |> List.map
            (\l ->
                Html.li
                    [ Html.Attributes.class "dev-card" ]
                    [ Html.h1
                        []
                        [ Portfolio.Common.link l.html_url l.name ]
                    , Html.p
                        [ Html.Attributes.class "language" ]
                        [ case l.language of
                            Nothing ->
                                Html.text ""

                            Just lang ->
                                Html.text lang
                        ]
                    , Html.p
                        [ Html.Attributes.class "description" ]
                        [ case l.description of
                            Nothing ->
                                Html.text ""

                            Just desc ->
                                Html.text desc
                        ]
                    ]
            )
        |> Html.ul
            [ Html.Attributes.class "github-repositories-panel" ]


developments : Model -> Html.Html msg
developments model =
    Html.div
        [ Html.Attributes.class "github-repositories" ]
        [ Html.h1
            []
            [ Html.text "Developments" ]
        , Html.p
            []
            [ Html.text "2019年度からは主にGo言語を用いて、OSS開発を行っています。"
            , Html.text "Go言語など実用性とシンプルさを重視した言語を好んで使用します。"
            ]
        , case model.state of
            Failure ->
                Html.text "I was unable to load repositories..."

            Loading ->
                Html.text "Loading..."

            Success fullRepos ->
                viewRepositories fullRepos
        , Html.div
            [ Html.Attributes.class "github-repositories-comment" ]
            [ Portfolio.Common.link
                "https://github.com/tomato3713"
                "show all GitHub repositories"
            ]
        ]


page : Root.Page Model Msg Route a
page =
    { route = route
    , init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlRequest = UrlRequest
    , session = \model -> model.session
    }
