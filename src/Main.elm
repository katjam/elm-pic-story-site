module Main exposing (..)

import Messages exposing (Msg(..))
import Model exposing (..)
import Navigation
import Route exposing (route)
import Subscriptions
import Update
import UrlParser as Url exposing (parseHash)
import View


main : Program Never Model Msg
main =
    Navigation.program locChange
        { init = Model.init
        , view = View.view
        , update = Update.update
        , subscriptions = Subscriptions.subscriptions
        }


locChange : Navigation.Location -> Msg
locChange location =
    parseHash route location
        |> UrlChange
