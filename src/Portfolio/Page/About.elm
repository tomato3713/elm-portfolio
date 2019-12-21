module Portfolio.Page.About exposing (Route, Model, Msg, route, page)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key, load, pushUrl)
import Html exposing (text, h1)
import Maybe exposing (Maybe(..))
import Url exposing (Url)
import Url.Parser exposing (Parser, map, s )
import Portfolio.Root as Root exposing (Flags, Session)

type Msg
  = UrlRequest UrlRequest


type alias Model
  = { session : Session, key : Key }


type alias Route
  = ()


route : Parser (Route -> a) a
route =
  map () (s "about")


init : Flags -> Url -> Key -> Route -> Maybe Session -> ( Model, Cmd Msg )
init _ _ key _ session
  = ( { session = Maybe.withDefault Root.initial session, key = key }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model
  = case msg of 
    UrlRequest urlRequest -> 
      case urlRequest of
        Internal url ->
          ( model, pushUrl model.key (Url.toString url) )
        External url -> 
          ( model, load url )

subscriptions : Model -> Sub Msg
subscriptions _
  = Sub.none


view : Model -> Document Msg
view model =
  { title = "About - Portfolio"
  , body = [ h1 [] [text "About"] ]
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

