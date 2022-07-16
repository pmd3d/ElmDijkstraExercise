module Main exposing (..)
-- https://stackoverflow.com/questions/57645824/how-can-i-listen-for-global-mouse-events-in-elm-0-19
-- elm install elm/json

import Browser
import Browser.Events exposing (onClick)
import Html exposing (Html, button, div, text, img)
import Html.Attributes exposing (src, width, height)
import Json.Decode as Decode


-- MAIN


main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }


-- MODEL


type alias Model = (Int, Int)

init : () -> (Model, Cmd Msg)
init _ = ( (0,0), Cmd.none )


-- UPDATE  


type Msg
  = MouseMsg Int Int

update : Msg -> Model -> (Model, Cmd Msg)
update msg (modelX, modelY) =
  case msg of

    MouseMsg x y -> 
      ((x, y), Cmd.none)


-- VIEW


view : Model -> Html Msg
view (modelX, modelY) =
  div []
    [ 
      img [src "../static/map.png", width 1200, height 901 ] [],
      div [] [ text (String.fromInt modelX) ],
      div [] [ text (String.fromInt modelY) ]
    ]

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  onClick
    (Decode.map2 MouseMsg
      (Decode.field "pageX" Decode.int)
      (Decode.field "pageY" Decode.int)
    )
