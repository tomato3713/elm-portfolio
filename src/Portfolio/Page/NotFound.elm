module Portfolio.Page.NotFound exposing (Model, Msg, Route, page, route)

import Browser exposing (Document, UrlRequest(..))
import Browser.Events
import Browser.Navigation
import Html
import Html.Attributes
import Keyboard
import Maybe exposing (Maybe(..))
import Portfolio.Common
import Portfolio.Root as Root
import Svg
import Svg.Attributes
import Url
import Url.Parser


type Msg
    = UrlRequest UrlRequest
    | Frame Float
    | KeyMsg Keyboard.Msg


type alias Model =
    { session : Root.Session
    , key : Browser.Navigation.Key
    , pressedKeys : List Keyboard.Key
    , speed : Float
    }


type alias Route =
    ()


route : Url.Parser.Parser (Route -> a) a
route =
    Url.Parser.custom "NOTHING" (\_ -> Nothing)


init : Root.Flags -> Url.Url -> Browser.Navigation.Key -> Route -> Maybe Root.Session -> ( Model, Cmd Msg )
init _ _ key _ session =
    ( { session = Maybe.withDefault Root.initial session
      , key = key
      , pressedKeys = []
      , speed = 0
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlRequest urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model, Browser.Navigation.pushUrl model.key (Url.toString url) )

                External url ->
                    ( model, Browser.Navigation.load url )

        Frame speed ->
            ( { model | speed = speed + 1 }, Cmd.none )

        KeyMsg keyMsg ->
            ( { model | pressedKeys = Keyboard.update keyMsg model.pressedKeys }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Browser.Events.onAnimationFrameDelta Frame
        , Sub.map KeyMsg Keyboard.subscriptions
        ]


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
            [ gameBox model
            ]
        , Portfolio.Common.footer
        ]
    }


gameBox : Model -> Html.Html msg
gameBox model =
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
            , Svg.Attributes.fill "rgb(192 192 192)"
            ]
            []
        , Portfolio.Common.blackCat
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
