
--------------------------
-- Auto-generated codes --
-- Do not edit this     --
--------------------------

module Alchelmy exposing (Flags, Model, Msg, Session, program)

import Browser exposing (Document, UrlRequest(..), application)
import Browser.Navigation exposing (Key, load, pushUrl)
import Html as Html exposing (Html, text)
import Maybe as Maybe exposing (Maybe(..))
import Url exposing (Url)
import Url.Parser as UrlParser exposing (s, oneOf, Parser, parse, (</>))
import Portfolio.Root as Root
import Portfolio.Page.NotFound
import Portfolio.Page.Products
import Portfolio.Page.Top


type alias Flags =
    Root.Flags


type alias Session =
    Root.Session


type Model = Model
  { state : RouteState
  , key : Key
  , flags : Root.Flags
  }

type Route
  = Route__Portfolio_Page_NotFound Portfolio.Page.NotFound.Route
  | Route__Portfolio_Page_Products Portfolio.Page.Products.Route
  | Route__Portfolio_Page_Top Portfolio.Page.Top.Route

type RouteState
  = State__Portfolio_Page_NotFound Portfolio.Page.NotFound.Model
  | State__Portfolio_Page_Products Portfolio.Page.Products.Model
  | State__Portfolio_Page_Top Portfolio.Page.Top.Model

type Msg
  = UrlRequest UrlRequest
  | Navigate Url
  | Msg__Portfolio_Page_NotFound Portfolio.Page.NotFound.Msg
  | Msg__Portfolio_Page_Products Portfolio.Page.Products.Msg
  | Msg__Portfolio_Page_Top Portfolio.Page.Top.Msg

currentSession : RouteState -> Root.Session
currentSession state = case state of 

        State__Portfolio_Page_NotFound pageModel ->
          Portfolio.Page.NotFound.page.session pageModel 

        State__Portfolio_Page_Products pageModel ->
          Portfolio.Page.Products.page.session pageModel 

        State__Portfolio_Page_Top pageModel ->
          Portfolio.Page.Top.page.session pageModel 


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
  case (msg, model.state) of
    (UrlRequest urlRequest, _) ->
          case model.state of

            State__Portfolio_Page_NotFound pmodel ->
                  case Portfolio.Page.NotFound.page.update (Portfolio.Page.NotFound.page.onUrlRequest urlRequest) pmodel of
                    (pmodel_, pcmd) ->
                      ( Model { model | state = State__Portfolio_Page_NotFound pmodel_ }
                      , Cmd.map Msg__Portfolio_Page_NotFound pcmd
                      )
        

            State__Portfolio_Page_Products pmodel ->
                  case Portfolio.Page.Products.page.update (Portfolio.Page.Products.page.onUrlRequest urlRequest) pmodel of
                    (pmodel_, pcmd) ->
                      ( Model { model | state = State__Portfolio_Page_Products pmodel_ }
                      , Cmd.map Msg__Portfolio_Page_Products pcmd
                      )
        

            State__Portfolio_Page_Top pmodel ->
                  case Portfolio.Page.Top.page.update (Portfolio.Page.Top.page.onUrlRequest urlRequest) pmodel of
                    (pmodel_, pcmd) ->
                      ( Model { model | state = State__Portfolio_Page_Top pmodel_ }
                      , Cmd.map Msg__Portfolio_Page_Top pcmd
                      )
        

    (Navigate location, _) ->
      case parseLocation location of

                Route__Portfolio_Page_NotFound routeValue ->
                      case Portfolio.Page.NotFound.page.init model.flags location model.key routeValue (Just (currentSession model.state)) of
                        (initialModel, initialCmd) ->
                          ( Model { model | state = State__Portfolio_Page_NotFound initialModel }
                          , Cmd.map Msg__Portfolio_Page_NotFound initialCmd
                          )
                

                Route__Portfolio_Page_Products routeValue ->
                      case Portfolio.Page.Products.page.init model.flags location model.key routeValue (Just (currentSession model.state)) of
                        (initialModel, initialCmd) ->
                          ( Model { model | state = State__Portfolio_Page_Products initialModel }
                          , Cmd.map Msg__Portfolio_Page_Products initialCmd
                          )
                

                Route__Portfolio_Page_Top routeValue ->
                      case Portfolio.Page.Top.page.init model.flags location model.key routeValue (Just (currentSession model.state)) of
                        (initialModel, initialCmd) ->
                          ( Model { model | state = State__Portfolio_Page_Top initialModel }
                          , Cmd.map Msg__Portfolio_Page_Top initialCmd
                          )
                
  

    (Msg__Portfolio_Page_NotFound pageMsg, State__Portfolio_Page_NotFound pageModel) ->
          case Portfolio.Page.NotFound.page.update pageMsg pageModel of
            (pageModel_, pageCmd ) ->
              (Model { model | state = State__Portfolio_Page_NotFound pageModel_ }, Cmd.map Msg__Portfolio_Page_NotFound pageCmd)
        

    (Msg__Portfolio_Page_Products pageMsg, State__Portfolio_Page_Products pageModel) ->
          case Portfolio.Page.Products.page.update pageMsg pageModel of
            (pageModel_, pageCmd ) ->
              (Model { model | state = State__Portfolio_Page_Products pageModel_ }, Cmd.map Msg__Portfolio_Page_Products pageCmd)
        

    (Msg__Portfolio_Page_Top pageMsg, State__Portfolio_Page_Top pageModel) ->
          case Portfolio.Page.Top.page.update pageMsg pageModel of
            (pageModel_, pageCmd ) ->
              (Model { model | state = State__Portfolio_Page_Top pageModel_ }, Cmd.map Msg__Portfolio_Page_Top pageCmd)
        

    (_, _) -> (Model model, Cmd.none)

documentMap : (msg -> Msg) -> Document msg -> Document Msg
documentMap f { title, body } = { title = title, body = List.map (Html.map f) body }

view : Model -> Document Msg
view (Model model) = case model.state of

  State__Portfolio_Page_NotFound m -> documentMap Msg__Portfolio_Page_NotFound (Portfolio.Page.NotFound.page.view m)
  State__Portfolio_Page_Products m -> documentMap Msg__Portfolio_Page_Products (Portfolio.Page.Products.page.view m)
  State__Portfolio_Page_Top m -> documentMap Msg__Portfolio_Page_Top (Portfolio.Page.Top.page.view m)

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ UrlParser.map Route__Portfolio_Page_NotFound Portfolio.Page.NotFound.page.route
        , UrlParser.map Route__Portfolio_Page_Products Portfolio.Page.Products.page.route
        , UrlParser.map Route__Portfolio_Page_Top Portfolio.Page.Top.page.route
        ]

parseLocation : Url -> Route
parseLocation location =
    case parse matchers location of
        Just route ->
            route

        Nothing ->
            Route__Portfolio_Page_NotFound ()

init : Root.Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags location key =

        case parseLocation location of

          Route__Portfolio_Page_NotFound routeValue -> case Portfolio.Page.NotFound.page.init flags location key routeValue Nothing of
                (initialModel, initialCmd) ->
                    ( Model
                        { state = State__Portfolio_Page_NotFound initialModel
                        , key = key
                        , flags = flags
                        }
                    , Cmd.map Msg__Portfolio_Page_NotFound initialCmd
                    )
                
          Route__Portfolio_Page_Products routeValue -> case Portfolio.Page.Products.page.init flags location key routeValue Nothing of
                (initialModel, initialCmd) ->
                    ( Model
                        { state = State__Portfolio_Page_Products initialModel
                        , key = key
                        , flags = flags
                        }
                    , Cmd.map Msg__Portfolio_Page_Products initialCmd
                    )
                
          Route__Portfolio_Page_Top routeValue -> case Portfolio.Page.Top.page.init flags location key routeValue Nothing of
                (initialModel, initialCmd) ->
                    ( Model
                        { state = State__Portfolio_Page_Top initialModel
                        , key = key
                        , flags = flags
                        }
                    , Cmd.map Msg__Portfolio_Page_Top initialCmd
                    )
                

subscriptions : Model -> Sub Msg
subscriptions (Model model) =
    case model.state of
        State__Portfolio_Page_NotFound routeValue -> Sub.map Msg__Portfolio_Page_NotFound (Portfolio.Page.NotFound.page.subscriptions routeValue)
        State__Portfolio_Page_Products routeValue -> Sub.map Msg__Portfolio_Page_Products (Portfolio.Page.Products.page.subscriptions routeValue)
        State__Portfolio_Page_Top routeValue -> Sub.map Msg__Portfolio_Page_Top (Portfolio.Page.Top.page.subscriptions routeValue)

program : Program Root.Flags Model Msg
program =
    application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequest
        , onUrlChange = Navigate
        }


