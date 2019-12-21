module Portfolio.Page.Top exposing (Model, Msg, Route, page, route)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key, load, pushUrl)
import Html exposing (Html, a, div, h1, p, text)
import Html.Attributes exposing (class, href)
import Maybe exposing (Maybe(..))
import Portfolio.Common exposing (link)
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
        [ h1 [] [ text "Top" ]
        , div [] [ p [] [ link "/about" "About" ] ]
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
