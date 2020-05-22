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


type alias Model =
    { session : Root.Session
    , key : Browser.Navigation.Key
    , pressedKeys : List Keyboard.Key
    , cat : Portfolio.Common.Cat
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
      , cat =
            { x = 37
            , y = 37
            , ax = 0
            , ay = 0
            }
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlRequest urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model
                    , Browser.Navigation.pushUrl model.key (Url.toString url)
                    )

                External url ->
                    ( model
                    , Browser.Navigation.load url
                    )

        Frame _ ->
            ( { model
                | cat =
                    { x =
                        if 0 < model.cat.x && model.cat.x < 70 then
                            model.cat.x + model.cat.ax

                        else
                            model.cat.x
                    , y =
                        if 0 < model.cat.y && model.cat.y < 70 then
                            model.cat.y + model.cat.ay

                        else
                            model.cat.y
                    , ax =
                        if model.cat.ax > 0 then
                            model.cat.ax - 1

                        else
                            model.cat.ax
                    , ay =
                        if model.cat.ay > 0 then
                            model.cat.ay - 1

                        else
                            model.cat.ay
                    }
              }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Browser.Events.onAnimationFrameDelta Frame
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
        , Svg.g
            [ Svg.Attributes.transform <|
                String.concat
                    [ "translate("
                    , String.fromFloat model.cat.x
                    , ","
                    , String.fromFloat model.cat.y
                    , ")"
                    ]
            ]
            [ Portfolio.Common.blackCat ]
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
