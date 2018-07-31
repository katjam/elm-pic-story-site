module ViewsConfigTests exposing (..)

import Test exposing (Test, describe, test, todo)
import Expect
import Views.Config exposing (appTitle, helpline, helplineDisplay)


all : Test
all =
    describe "Testing Config.elm returns the correct values"
        [ describe "Constants"
            [ test "App title" <|
                \() ->
                    appTitle |> Expect.equal "You Matter"
            , test "Helpline phone number" <|
                \() ->
                    helpline |> Expect.equal "08000194400"
            , test "Helpline phone number display" <|
                \() ->
                    helplineDisplay |> Expect.equal ("08000" ++ " " ++ "194" ++ " " ++ "400")
            ]
        ]
