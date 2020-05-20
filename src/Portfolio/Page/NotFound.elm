module Portfolio.Page.NotFound exposing (Model, Msg, Route, page, route)

import Browser exposing (Document, UrlRequest(..))
import Browser.Events exposing (onAnimationFrameDelta)
import Browser.Navigation exposing (Key, load, pushUrl)
import Html
import Html.Attributes
import Maybe exposing (Maybe(..))
import Portfolio.Common
import Portfolio.Root as Root exposing (Flags, Session)
import Svg
import Svg.Attributes
import Url exposing (Url)
import Url.Parser


type Msg
    = UrlRequest UrlRequest
    | Frame Float


type alias Model =
    { session : Session
    , key : Key
    , count : Float
    }


type alias Route =
    ()


route : Url.Parser.Parser (Route -> a) a
route =
    Url.Parser.custom "NOTHING" (\_ -> Nothing)


init : Flags -> Url -> Key -> Route -> Maybe Session -> ( Model, Cmd Msg )
init _ _ key _ session =
    ( { session = Maybe.withDefault Root.initial session, key = key, count = 0 }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlRequest urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model, pushUrl model.key (Url.toString url) )

                External url ->
                    ( model, load url )

        Frame count ->
            ( { model | count = count + 1 }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Browser.Events.onAnimationFrameDelta Frame


view : Model -> Document Msg
view model =
    { title = "eim-world - NotFound"
    , body =
        [ Portfolio.Common.header "NotFound"
        , Html.p
            []
            [ Html.text "404 Not found." ]
        , Html.div
            [ Html.Attributes.class "contents" ]
            [ Html.div
                []
                [ Html.text ("Count: " ++ String.fromFloat model.count) ]
            , viewSvg
            ]
        , Portfolio.Common.footer
        ]
    }


viewSvg : Html.Html msg
viewSvg =
    Svg.svg
        [ Html.Attributes.width 400
        , Html.Attributes.height 400
        , Svg.Attributes.viewBox "0 0 120 120"
        ]
        [ Svg.rect
            [ Svg.Attributes.x "10"
            , Svg.Attributes.y "10"
            , Svg.Attributes.width "100"
            , Svg.Attributes.height "100"
            , Svg.Attributes.rx "15"
            , Svg.Attributes.ry "15"
            , Svg.Attributes.fill "blue"
            ]
            []
        , Svg.circle
            [ Svg.Attributes.cx "60"
            , Svg.Attributes.cy "60"
            , Svg.Attributes.r "20"
            , Svg.Attributes.fill "red"
            ]
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
