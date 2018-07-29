module Subscriptions exposing (..)

import Messages exposing (Msg(..))
import Keyboard
import Model exposing (Model)
import Mouse


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.clicks MouseAction
        , Keyboard.downs KeyPress
        ]
