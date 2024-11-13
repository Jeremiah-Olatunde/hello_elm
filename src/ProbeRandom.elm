module ProbeRandom exposing (..)

import Browser
import Html exposing (Html, br, button, div, text)
import Html.Events exposing (onClick)
import Random


main =
    Browser.element { init = init, view = view, update = update, subscriptions = subscriptions }


type Model
    = Loading
    | Number Int


type Message
    = Generate
    | Generated Int


init : () -> ( Model, Cmd Message )
init _ =
    ( Loading, Random.generate Generated (Random.int 0 10) )


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        Generate ->
            ( Loading, Random.generate Generated (Random.int 0 10) )

        Generated n ->
            ( Number n, Cmd.none )


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.none


view : Model -> Html Message
view model =
    case model of
        Loading ->
            div [] [ text "generating random number" ]

        Number n ->
            div
                []
                [ text ("random number: " ++ String.fromInt n)
                , br [] []
                , button [ onClick Generate ] [ text "new" ]
                ]
