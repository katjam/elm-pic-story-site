module Model exposing (..)

import Messages exposing (Msg(..), delay, pageTimeoutSecs)
import Navigation
import Route exposing (Page(..), route)
import Slug exposing (Slug)
import UrlParser as Url exposing (parseHash)


type alias Model =
    { currentPage : Page
    , idlePage : Page
    , idleTimerCount : Int
    , doExit : Bool
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        page =
            case parseHash route location of
                Nothing ->
                    Home

                Just page ->
                    page
    in
        ( Model page Home 0 False, delay pageTimeoutSecs (IdleTimeout page -1) )


pageSlug : Page -> String
pageSlug page =
    case Slug.generate (toString page) of
        Just slug ->
            Slug.toString slug

        Nothing ->
            ""
