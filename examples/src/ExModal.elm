module ExModal exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Modal


type alias Model =
    { active : Bool
    , value : String
    , tmp : String
    }


type Msg
    = OnModal Bool
    | OnValue String
    | OnSave


view : Model -> Html Msg
view model =
    div [ class "ex-modal" ]
        [ button [ class "btn", onClick <| OnModal True ] [ text "Open modal" ]
        , p []
              [ span [ class "leg" ] [text "value: " ]
              , span [ class "value" ] [ text model.value ]
              ]
        , Modal.view config model.active
        ]


config : Modal.Config Msg
config =
    Modal.default (OnModal False) OnSave "Modal example" <|
        div []
            [ span [] [ text "Value: " ]
            , input [ type_ "text", onInput OnValue ] []
            ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        OnModal v ->
            { model | active = v }

        OnValue v ->
            { model | tmp = v }

        OnSave ->
            { model | value = model.tmp, active = False }


main : Program () Model Msg
main =
    Browser.sandbox
        { init = Model False "-" ""
        , view = view
        , update = update
        }
