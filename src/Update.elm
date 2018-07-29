module Update exposing (update)

import Messages exposing (Msg(..), delay, gaEvent, hidePage, pageTimeoutSecs, updateAnalyticsEvent, updateAnalyticsPage)
import Model exposing (..)
import Navigation
import Route exposing (Page(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        --
        -- Action messages
        --
        ButtonPress category action label withPage ->
            case withPage of
                True ->
                    ( model
                    , updateAnalyticsEvent (gaEvent category action (label ++ "_" ++ pageSlug model.currentPage))
                    )

                False ->
                    ( model
                    , updateAnalyticsEvent (gaEvent category action label)
                    )

        KeyPress position ->
            ( { model | idleTimerCount = model.idleTimerCount + 1 }
            , delay pageTimeoutSecs (IdleTimeout model.currentPage model.idleTimerCount)
            )

        MouseAction code ->
            ( { model | idleTimerCount = model.idleTimerCount + 1 }
            , delay pageTimeoutSecs (IdleTimeout model.currentPage model.idleTimerCount)
            )

        --
        -- Navigation messages
        --
        NewUrl url ->
            ( model
            , Navigation.newUrl url
            )

        UrlChange location ->
            case location of
                Nothing ->
                    ( { model | currentPage = Home }, Cmd.none )

                Just page ->
                    -- Keep count of the "time to idle" timers so only the most recent will take action.
                    { model | currentPage = page, idleTimerCount = model.idleTimerCount + 1 }
                        ! -- ! Means you can pass a list of commands.
                          [ updateAnalyticsPage (pageSlug page)

                          -- When the page changes, we need to kickoff a timer.
                          , delay pageTimeoutSecs (IdleTimeout page model.idleTimerCount)
                          ]

        --
        -- Timeout messages
        --
        DoTimeout ->
            -- The most recent idle Timer had hit the timelimit - kick off the Exit process.
            { model | currentPage = Timeout, doExit = True }
                ! [ updateAnalyticsPage ("timeout-warning_" ++ (pageSlug model.idlePage))
                  , updateAnalyticsEvent (gaEvent "exit" "auto" ("warning_" ++ pageSlug model.idlePage))
                  , delay 15 (Exit False)
                  ]

        Exit force ->
            case force of
                False ->
                    let
                        cmds =
                            if model.doExit == True then
                                [ updateAnalyticsEvent (gaEvent "exit" "auto" ("timed-out_" ++ pageSlug model.idlePage))
                                , Navigation.load "https://google.com"
                                ]
                            else
                                [ Cmd.none ]
                    in
                        (model ! cmds)

                True ->
                    model
                        ! -- Hide the page immediately with JavaScript
                          [ hidePage (Nothing)
                          , updateAnalyticsEvent (gaEvent "exit" "force" ("exit-button_" ++ pageSlug model.currentPage))

                          -- Then redirect to Google
                          , Navigation.load "https://google.com"
                          ]

        GoBack ->
            -- We pressed go back to stop the timeout. Go back to the page we came from, stop exit, restart idle timer.
            { model | currentPage = model.idlePage, doExit = False, idleTimerCount = model.idleTimerCount + 1 }
                ! [ updateAnalyticsPage "go-back-triggered"
                  , updateAnalyticsEvent (gaEvent "exit" "cancel" ("keep-reading_" ++ pageSlug model.idlePage))
                  , delay pageTimeoutSecs (IdleTimeout model.idlePage model.idleTimerCount)
                  ]

        IdleTimeout page idleTimerCount ->
            ( { model | idlePage = page }
            , -- Only load the timeout screen if this is the most recent idle timer.
              if model.idleTimerCount == (idleTimerCount + 1) then
                delay 0 DoTimeout
              else
                Cmd.none
            )
