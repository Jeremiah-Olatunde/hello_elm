module ProbeTime exposing (..)

import Browser
import Html exposing (Html, div, text)
import Task
import Time


main =
    Browser.element { init = init, view = view, update = update, subscriptions = subscriptions }


type Model
    = Loading
    | Data Time.Posix


type Message
    = Now Time.Posix


init : () -> ( Model, Cmd Message )
init _ =
    ( Loading, Task.perform Now Time.now )


update : Message -> Model -> ( Model, Cmd Message )
update (Now time) model =
    ( Data time, Cmd.none )



--case message of
--Now time ->
--( Data time, Cmd.none )


view : Model -> Html Message
view model =
    case model of
        Loading ->
            div [] [ text "loading time..." ]

        Data posix ->
            div [] [ text <| String.fromInt <| Time.posixToMillis <| posix ]


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.none
