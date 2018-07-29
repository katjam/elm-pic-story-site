-- Views/Pages/Supporters.elm


module Views.Pages.Supporters exposing (supportersContent)

import Assets exposing (AssetPath(..), path)
import Html exposing (..)
import Html.Attributes exposing (alt, class, href, src)
import Messages exposing (Msg(..))
import Views.Footer exposing (footerContent)


supportersContent : Html Msg
supportersContent =
    div [ class " section section--lighter" ]
        [ div []
            [ h2 [] [ text "Our Supporters" ]
            , p [] [ text "We would like to thank our funders, whose generosity has made this website possible." ]
            ]

        -- footer should probably be outside content container but this is easiest for now.
        -- It is conditional on page. Could hide in the story pages with css? But not sure that's any better.
        , footerContent
        ]
