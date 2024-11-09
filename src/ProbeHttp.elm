module ProbeHttp exposing (..)

import Browser
import Debug
import Html exposing (Html, button, div, h1, hr, li, p, section, text, ul)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (Decoder, field, int, list, map3, string)


main =
    Browser.element { init = init, view = view, update = update, subscriptions = subscriptions }


type Model
    = Failure
    | Loading
    | Success (List User)


type alias Message =
    Result Http.Error (List User)


type alias User =
    { name : String
    , email : String
    , id : Int
    }


nameDecoder : Decoder String
nameDecoder =
    field "name" string


emailDecoder : Decoder String
emailDecoder =
    field "email" string


idDecoder : Decoder Int
idDecoder =
    field "id" int


userDecoder : Decoder User
userDecoder =
    map3 User nameDecoder emailDecoder idDecoder


init : () -> ( Model, Cmd Message )
init _ =
    ( Loading
    , Http.get { url = "https://jsonplaceholder.typicode.com/users", expect = Http.expectJson identity (list userDecoder) }
    )


subscriptions : Model -> Sub Message
subscriptions _ =
    Sub.none



-- Success [ { name = "Jesuseun Olatunde", email = "jesuseun.j.olatunde@gmail.com", id = "skdpweodpem" } ]


update : Message -> Model -> ( Model, Cmd Message )
update message _ =
    case message of
        Ok users ->
            ( Success users, Cmd.none )

        Err error ->
            ( Failure, Cmd.none )


view : Model -> Html Message
view model =
    case model of
        Loading ->
            div [] [ text "fetching users" ]

        Failure ->
            div [] [ text "failed to fetch users" ]

        Success users ->
            if List.isEmpty users then
                div [] [ text "no users to show" ]

            else
                users |> List.map viewUser |> div []


viewUser : User -> Html Message
viewUser { id, name, email } =
    section
        []
        [ h1 [] [ text name ]
        , p
            []
            [ text "details:" ]
        , ul
            []
            [ li [] [ text ("id: " ++ String.fromInt id) ]
            , li [] [ text ("name: " ++ name) ]
            , li [] [ text ("email: " ++ email) ]
            ]
        , hr [] []
        ]
