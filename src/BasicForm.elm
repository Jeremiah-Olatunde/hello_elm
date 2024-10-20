module BasicForm exposing (main)

import Browser
import Html exposing (Html, label, input, text, form, button)
import Html.Attributes exposing (id, for, value, placeholder, style)
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


styleForm = 
  [ style "display" "flex" 
  , style "flex-direction" "column"
  , style "width" "400px"
  , style "margin" "auto"
  , style "padding" "20px"
  ] 

styleInput =
  [ style "margin" "10px 0"
  , style "padding" "10px 5px"
  ]

styleButton = 
  [ style "padding" "10px"
  , style "text-transform" "uppercase"
  ]

view : Model ->  Html Message
view model =
  form 
    ([] ++ styleForm) 
    [ label 
        [ for "username" ] 
        [ text "username" ]
    , input
        (
          styleInput ++ 
          [ id "username" 
          , value (.username model)
          , onInput UpdateUsername 
          , placeholder "enter username"
          ]
        ) 
         []
    , label 
        [ for "password"]  
        [ text "password" ]
    , input 
        (
          styleInput ++ 
          [ id "password" 
          , value (.password model)
          , onInput UpdatePassword 
          , placeholder "enter password"
          ]
        ) 
        []
    , button ([] ++ styleButton) [ text "submit" ]
    ]