module BasicForm exposing (main)

import Browser
import Html exposing (Html, label, input, text, form, button)
import Html.Attributes exposing (id, for, value, placeholder)
import Html.Events exposing (onInput)

main = 
  Browser.sandbox { view = view, update = update, init = init }


type alias Model = { username: String, password: String }

init: Model
init = { username = "", password = "" }


type Message = UpdateUsername String | UpdatePassword String

update :  Message -> Model -> Model
update message model =
  case message of
    UpdateUsername username -> { model | username = username }
    UpdatePassword password -> { model | password = password }


view : Model ->  Html Message
view model =
  form 
    [] 
    [ label 
        [ for "username" ] 
        [ text "username" ]
    , input 
        [ id "username" 
        , value (.username model)
        , onInput UpdateUsername 
        , placeholder "enter username"
        ] []
    , label 
        [ for "password"]  
        [ text "password" ]
    , input 
        [ id "password" 
        , value (.password model)
        , onInput UpdatePassword 
        , placeholder "enter password"
        ] []
    , button [] [ text "submit" ]
    ]