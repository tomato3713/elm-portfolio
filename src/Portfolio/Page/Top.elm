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
    Json.Decode.map2 GitHubRepo
        (Json.Decode.field "name" Json.Decode.string)
        (Json.Decode.field "html_url" Json.Decode.string)
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
    { title = "Top - Portfolio"
    , body =
        [ Html.h1 []
            [ Html.text "Top" ]
        , Portfolio.Common.menu
        , Html.div []
            [ Html.div
                [ Html.Attributes.class "about-site" ]
                [ Html.h2 []
                    [ Html.text "About Site" ]
                , Html.text "このWebサイトは、私の製作物、経験について記載する個人サイトです。"
                ]
            , Html.div
                [ Html.Attributes.class "self-introduction"
                ]
                [ Html.h2 []
                    [ Html.text "Self Introduction" ]
                , Html.div []
                    [ Html.dl
                        [ Html.Attributes.class "definition_list" ]
                        [ Portfolio.Common.definitionItem "Name" "Taichi Watanabe"
                        , Portfolio.Common.definitionItem "Programming Languages" "Go, Java, Ruby, Python, JavaScript, CSS, Elm, C#, Lisp"
                        , Portfolio.Common.definitionItem "Experience" "HP development, Wordpress, dotNet, API Client Library, Server Monitoring (Mackerel)"
                        , Portfolio.Common.definitionItem "Works (Part time jobs)" "現在は、WEBSYS (社会人向けIT教育プログラム) のスタッフをしています。また、趣味としてGo言語を中心に用いたOSS開発を行っています。"
                        ]
                    ]
                ]
            , developments model
            ]
        ]
    }



--- GitHub repository component


viewRepositories : List GitHubRepo -> Html.Html msg
viewRepositories repos =
    repos
        |> List.map (\l -> Html.li [] [ Portfolio.Common.link l.html_url l.name ])
        |> Html.ul []


developments : Model -> Html.Html msg
developments model =
    Html.div
        [ Html.Attributes.class "developments" ]
        [ Html.div
            [ Html.Attributes.class "developments-title" ]
            [ Html.text "Developments" ]
        , case model.state of
            Failure ->
                Html.text "I was unable to load repositories..."

            Loading ->
                Html.text "Loading..."

            Success fullRepos ->
                viewRepositories fullRepos
        , Html.div
            [ Html.Attributes.class "developments-item" ]
            []
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
