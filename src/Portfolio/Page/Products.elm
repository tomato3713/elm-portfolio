module Portfolio.Page.Products exposing (Model, Msg, Route, page, route)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key, load, pushUrl)
import Html
import Html.Attributes
import Maybe exposing (Maybe(..))
import Portfolio.Common
import Portfolio.Root as Root exposing (Flags, Session)
import Url exposing (Url)
import Url.Parser


type Msg
    = UrlRequest UrlRequest


type alias Model =
    { session : Session
    , key : Key
    }


type alias Route =
    ()


route : Url.Parser.Parser (Route -> a) a
route =
    Url.Parser.map () (Url.Parser.s "products")


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
view _ =
    { title = "Products - Portfolio"
    , body =
        [ Html.h1
            []
            [ Html.text "Products" ]
        , Portfolio.Common.menu
        , Html.div
            [ Html.Attributes.class "contents" ]
            [ Html.p
                [ Html.Attributes.class "about-technology" ]
                [ Html.text
                    "N88互換Basic for Windows95 でシューティングゲームを作った時の感動が忘れられず、大学生となった今プログラミングだけでなくコンピュータサイエンス全般を理解すべく学習しています。"
                ]
            , Html.p
                [ Html.Attributes.class "about-technology" ]
                [ Html.text
                    "サーバ管理・運用技術及び開発支援ツールに特に関心を持って取り組んでいます。言語については、C言語、JavaScript、Elm、Ruby等多彩な言語に触れてきたが、簡潔で協力な記述能力を持つGo言語を好んで使用しています。個人での製作の他に、チームでの開発経験があります。"
                ]
            , Html.p
                [ Html.Attributes.class "about-technology" ]
                [ Html.text
                    "チームとしてだけでなく、個人としても社会に貢献できるように高い技術を持つことが第一目標です。"
                ]
            , Html.div
                [ Html.Attributes.class "products-content" ]
                [ Html.h1
                    []
                    []
                ]
            ]
        , Portfolio.Common.linklist
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
