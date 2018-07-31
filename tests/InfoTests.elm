module InfoTests exposing (..)

import Test exposing (Test, describe, test, todo)
import Expect
import Info exposing (getInfo)


all : Test
all =
    describe "Testing Info.elm returns the correct name, icon and page slug"
        [ describe "Info name"
            [ test "Index of 1" <|
                \() ->
                    (getInfo 1).name |> Expect.equal "What happens if I call The Haven helpline?"
            , test "Index of 2" <|
                \() ->
                    (getInfo 2).name |> Expect.equal "I'm worried about immigration"
            , test "Index of 3" <|
                \() ->
                    (getInfo 3).name |> Expect.equal "I'm thinking about leaving"
            , test "Index of 4" <|
                \() ->
                    (getInfo 4).name |> Expect.equal "Will Social Services get involved?"
            , test "Index of 5" <|
                \() ->
                    (getInfo 5).name |> Expect.equal "I'm worried about money"
            , test "Index of 6" <|
                \() ->
                    (getInfo 6).name |> Expect.equal "What will happen if I tell the Police?"
            , test "Index of 0" <|
                \() ->
                    (getInfo 0).name |> Expect.equal "Not found"
            , test "Index of 500" <|
                \() ->
                    (getInfo 500).name |> Expect.equal "Not found"
            ]
        , describe "Info slug"
            [ test "Index of 1" <|
                \() ->
                    (getInfo 1).slug |> Expect.equal "helpline"
            , test "Index of 2" <|
                \() ->
                    (getInfo 2).slug |> Expect.equal "worried-about-immigration"
            , test "Index of 3" <|
                \() ->
                    (getInfo 3).slug |> Expect.equal "thinking-about-leaving"
            , test "Index of 4" <|
                \() ->
                    (getInfo 4).slug |> Expect.equal "social-services"
            , test "Index of 5" <|
                \() ->
                    (getInfo 5).slug |> Expect.equal "worried-about-money"
            , test "Index of 6" <|
                \() ->
                    (getInfo 6).slug |> Expect.equal "talking-to-police"
            , test "Index of 0" <|
                \() ->
                    (getInfo 0).slug |> Expect.equal "not-found"
            , test "Index of 500" <|
                \() ->
                    (getInfo 500).slug |> Expect.equal "not-found"
            ]
        , describe "Info icon"
            [ test "Index of 1" <|
                \() ->
                    (getInfo 1).icon |> Expect.equal "call"
            , test "Index of 2" <|
                \() ->
                    (getInfo 2).icon |> Expect.equal "id-card"
            , test "Index of 3" <|
                \() ->
                    (getInfo 3).icon |> Expect.equal "leaving"
            , test "Index of 4" <|
                \() ->
                    (getInfo 4).icon |> Expect.equal "children"
            , test "Index of 5" <|
                \() ->
                    (getInfo 5).icon |> Expect.equal "pound"
            , test "Index of 6" <|
                \() ->
                    (getInfo 6).icon |> Expect.equal "police-bold"
            , test "Index of 0" <|
                \() ->
                    (getInfo 0).icon |> Expect.equal "question"
            , test "Index of 500" <|
                \() ->
                    (getInfo 500).icon |> Expect.equal "question"
            ]
        ]
