module Portfolio.Page.Products exposing (Model, Msg, Route, page, route)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key, load, pushUrl)
import Html exposing (h1, text)
import Maybe exposing (Maybe(..))
import Portfolio.Common
import Portfolio.Root as Root exposing (Flags, Session)
import Url exposing (Url)
import Url.Parser exposing (Parser, map, s)


type Msg
    = UrlRequest UrlRequest


type alias Model =
    { session : Session, key : Key }


type alias Route =
    ()


route : Parser (Route -> a) a
route =
    map () (s "products")


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
    { title = "Products - Portfolio"
    , body =
        [ h1 [] [ text "Products" ]
        , Portfolio.Common.menu
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
