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
    { title = "tomato - Products"
    , body =
        [ Portfolio.Common.header "Products"
        , Html.div
            [ Html.Attributes.class "contents" ]
            [ comment
            , cwWebRunner
            , goSoumuradio
            , pegeonQuest
            , json2texAddressLetter
            ]
        , Portfolio.Common.footer
        ]
    }


comment : Html.Html msg
comment =
    Html.div
        [ Html.Attributes.class "products-about-technology" ]
        [ Html.p
            []
            [ Html.text
                "N88互換Basic for Windows95 でシューティングゲームを作った時の感動が忘れられず、大学生となった今プログラミングだけでなくコンピュータサイエンス全般を理解すべく学習しています。"
            ]
        , Html.p
            []
            [ Html.text
                "サーバ管理・運用技術及び開発支援ツールに特に関心を持って取り組んでいます。言語については、C言語、JavaScript、Elm、Ruby等多彩な言語に触れてきたが、簡潔で協力な記述能力を持つGo言語を好んで使用しています。個人での製作の他に、チームでの開発経験があります。"
            ]
        , Html.p
            []
            [ Html.text
                "チームとしてだけでなく、個人としても社会に貢献できるように高い技術を持つことが第一目標です。"
            ]
        ]


cwWebRunner : Html.Html msg
cwWebRunner =
    Html.div
        [ Html.Attributes.class "products-content" ]
        [ Html.h1
            [ Html.Attributes.class "products-content-title" ]
            [ Html.text "CW Web Runner / Tutor" ]
        , Html.div
            [ Html.Attributes.class "products-content-body" ]
            [ Portfolio.Common.link
                "https://github.com/tomato3713/cw_for_web"
                "Repository"
            , Html.div
                []
                [ Html.img
                    [ Html.Attributes.src "./cw-web-runner.jpg"
                    ]
                    []
                , Html.p
                    []
                    [ Html.text "モールス符号の聞き取り練習を行うソフトウェア及びwebサイトはいくつかあります。しかし、それらはゲーム性にかける、限られたOSでしか使用できないといった問題がありました。そのため、WebブラウザをプラットフォームとすることでDesktopとスマートフォンの両方で同じ使用感で練習ができ、かつゲーム性を持った"
                    , Portfolio.Common.link "https://homedm.eim.world/cw_for_web/" "モールス符号聞き取り練習サイト"
                    , Html.text "を開発しました。"
                    ]
                ]
            ]
        ]


pegeonQuest : Html.Html msg
pegeonQuest =
    Html.div
        [ Html.Attributes.class "products-content" ]
        [ Html.h1
            [ Html.Attributes.class "products-content-title" ]
            [ Html.text "Pegeon Quest" ]
        , Html.div
            []
            [ Portfolio.Common.link
                "https://github.com/tomato3713/pegeon-quest"
                "Repository"
            , Html.p
                []
                [ Html.text "大学の授業「メディア情報学プログラミング演習」の課題として3人のグループで製作した作品です。「鳩のような鳩ではない何かを育成する」をコンセプトに育成ゲームとタイピングゲームを融合させたゲームとなっています。MVCモデルを採用し、Javaで開発を行いました。"
                ]
            ]
        ]


json2texAddressLetter : Html.Html msg
json2texAddressLetter =
    Html.div
        [ Html.Attributes.class "products-content" ]
        [ Html.h1
            [ Html.Attributes.class "products-content-title" ]
            [ Html.text "json2tex address letter" ]
        , Html.div
            []
            [ Portfolio.Common.link
                "https://github.com/tomato3713/json2tex-address-letter"
                "Repository"
            , Html.p
                []
                [ Html.text
                    "json形式の宛名リストを読み込み、宛名面のPDFを出力します。LaTex を用いてPDFを生成します。"
                ]
            ]
        ]


goSoumuradio : Html.Html msg
goSoumuradio =
    Html.div
        [ Html.Attributes.class "products-content" ]
        [ Html.h1
            [ Html.Attributes.class "products-content-title" ]
            [ Html.text "go-soumuradio package" ]
        , Html.div
            []
            [ Portfolio.Common.link
                "https://github.com/tomato3713/go-soumuradio"
                "Repository"
            , Html.p
                []
                [ Html.text
                    "総務省が提供している無線局等情報検索 Web API のためのGo言語のAPIクライアントライブラリです。ブログにて、パッケージを開発した際に書いた"
                , Portfolio.Common.link
                    "https://tomato3713.hatenablog.com/entry/2019/12/22/120000"
                    "記事"
                , Html.text
                    "を公開しています。"
                ]
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
