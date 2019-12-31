module Portfolio.Page.Top exposing (Model, Msg, Route, page, route)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key, load, pushUrl)
import Html
import Html.Attributes exposing (class, href)
import Maybe exposing (Maybe(..))
import Portfolio.Common
import Portfolio.Root as Root exposing (Flags, Session)
import Url exposing (Url)
import Url.Parser as UrlParser exposing (Parser, map, s, top)


type Msg
    = UrlRequest UrlRequest


type alias Model =
    { session : Session, key : Key }


type alias Route =
    ()


route : Parser (Route -> a) a
route =
    map () top


init : Flags -> Url -> Key -> Route -> Maybe Session -> ( Model, Cmd Msg )
init _ _ key _ session =
    ( { session = Maybe.withDefault Root.initial session, key = key }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlRequest urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model, pushUrl model.key (Url.toString url) )

                External url ->
                    ( model, load url )


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
                    [ Html.dl []
                        [ Portfolio.Common.definitionItem "Name" "Taichi Watanabe"
                        , Portfolio.Common.definitionItem "学校" "国立大学法人 電気通信大学 (UEC)"
                        , Portfolio.Common.definitionItem "Programming Languages" "Go, Java, Ruby, Python, JavaScript, CSS, Elm, C#, Lisp"
                        , Portfolio.Common.definitionItem "Experience" "HP development, Wordpress, dotNet, API Client Library, Server Monitoring (Mackerel)"
                        , Portfolio.Common.definitionItem "Works (Part time jobs)" "WEBSYS (社会人向けIT教育プログラム) のスタッフをしています。株式会社はてなにてサマーインターンシップ (2019) に参加していました。"
                        ]
                    ]
                ]
            ]
        ]
    }


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
