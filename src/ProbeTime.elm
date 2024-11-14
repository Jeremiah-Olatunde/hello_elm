module ProbeTime exposing (..)

import Browser
import Debug
import Html exposing (Html, div, text)
import Task
import Time


main =
    Browser.element { init = init, view = view, update = update, subscriptions = subscriptions }


type ModelTime
    = LoadingTime
    | CurrentTime Time.Posix


type ModelZone
    = LoadingZone
    | CurrentZone Time.Zone


type alias Model =
    { time : ModelTime, zone : ModelZone }


type Message
    = TimeData Time.Posix Time.Zone
    | Tick Time.Posix


init : () -> ( Model, Cmd Message )
init _ =
    ( { time = LoadingTime, zone = LoadingZone }, Task.perform identity (Task.map2 TimeData Time.now Time.here) )


update : Message -> Model -> ( Model, Cmd Message )
update message { time, zone } =
    case message of
        TimeData t z ->
            ( Model (CurrentTime t) (CurrentZone z), Cmd.none )

        Tick t ->
            ( Model (CurrentTime t) zone, Cmd.none )



--case message of
--CurrentTime time ->
--( Data time, Cmd.none )


view : Model -> Html Message
view { time, zone } =
    case time of
        LoadingTime ->
            div [] [ text "loading posix time..." ]

        CurrentTime t ->
            case zone of
                LoadingZone ->
                    div [] [ text "loading time zone." ]

                CurrentZone z ->
                    div
                        []
                        [ div [] [ text <| (++) "year: " <| String.fromInt <| Time.toYear z t ]
                        , div [] [ text <| (++) "month: " <| Debug.toString <| Time.toMonth z t ]
                        , div [] [ text <| (++) "weekday: " <| Debug.toString <| Time.toWeekday z t ]
                        , div [] [ text <| (++) "hour: " <| Debug.toString <| Time.toHour z t ]
                        , div [] [ text <| (++) "minute: " <| Debug.toString <| Time.toMinute z t ]
                        , div [] [ text <| (++) "second: " <| Debug.toString <| Time.toSecond z t ]
                        ]


subscriptions : Model -> Sub Message
subscriptions model =
    Time.every 1000 Tick
