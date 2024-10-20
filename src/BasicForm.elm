module BasicForm exposing (main)

import Browser
import Html exposing (Html, label, input, text, form, button, div)
import Html.Attributes exposing (id, for, value, placeholder, style, type_)
import Html.Events exposing (onInput, onSubmit, onClick)

main = 
  Browser.sandbox { view = view, update = update, init = init }


type alias FormData = { username: String, password: String }
type Model = Success | Form FormData

init: Model
init = Form { username = "", password = "" }


type Message = UpdateUsername String | UpdatePassword String | SubmitForm

update :  Message -> Model -> Model
update message model =
  case message of
    SubmitForm -> Success
    UpdateUsername username -> 
      case model of 
        Form formData -> Form { formData | username = username }
        Success -> Success
    UpdatePassword password ->
      case model of 
        Form formData -> Form { formData | password = password }
        Success -> Success      

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
  case model of 
    Success -> div [] [ text "SUCCESS" ]
    Form formData -> 
      form 
        ([] ++ styleForm) 
        [ label 
            [ for "username" ] 
            [ text "username" ]
        , input
            (
              styleInput ++ 
              [ id "username" 
              , value (.username formData)
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
              , value (.password formData)
              , onInput UpdatePassword 
              , placeholder "enter password"
              ]
            ) 
            []
        --, input ([ onSubmit SubmitForm, value "submit", type_ "submit" ] ++ styleButton) []
        , button ([ onClick SubmitForm ] ++ styleButton) [ text "submit" ]
        ]