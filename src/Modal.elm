module Modal exposing
    ( Button, Config, Model, Size(..)
    , default, view
    )

{-| Modal component.


## Types

@docs Button, Config, Model, Size


## Functions

@docs default, view

-}

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


{-| Modal model (active or not).
-}
type alias Model =
    Bool


{-| Modal size.
-}
type Size
    = Small
    | Medium
    | Big


{-| Modal configuration. If save is nothing, the save button is hidden.

Example

    { title = "My Modal title"
    , size = Medium
    , content = div [] [...]
    , close = Button "Close" OnClose True
    , save = Just <| Button "Save" OnSave True
    }

-}
type alias Config msg =
    { title : String
    , size : Size
    , content : Html msg
    , close : Button msg
    , save : Maybe (Button msg)
    }


{-| Modal button.
-}
type alias Button msg =
    { title : String
    , trigger : msg
    , enable : Bool
    }


{-| Modal view.
-}
view : Config msg -> Model -> Html msg
view c active =
    let
        btn =
            case c.save of
                Nothing ->
                    text ""

                Just b ->
                    button
                        [ class ("button is-success " ++ bs b.enable "" "is-disabled")
                        , onClick b.trigger
                        ]
                        [ text b.title ]
    in
    div
        [ class ("modal " ++ bs active "is-active" "") ]
        [ div [ class "modal-background" ] []
        , div [ class "modal-card", style "width" (modalWidth c.size) ]
            [ header [ class "modal-card-head" ]
                [ p [ class "modal-card-title" ] [ text c.title ]
                , button [ class "delete", onClick c.close.trigger, attribute "aria-label" "close" ] []
                ]
            , section [ class "modal-card-body" ] [ c.content ]
            , footer [ class "modal-card-foot" ]
                [ btn
                , button
                    [ class "button"
                    , onClick c.close.trigger
                    ]
                    [ text c.close.title ]
                ]
            ]
        ]


{-| Default configuration for the modal view.
-}
default : msg -> msg -> String -> Html msg -> Config msg
default onClose onSave title content =
    { title = title
    , size = Medium
    , content = content
    , close = Button "Close" onClose True
    , save = Just <| Button "Save" onSave True
    }


bs : Bool -> String -> String -> String
bs b y n =
    if b then
        y

    else
        n


modalWidth : Size -> String
modalWidth size =
    case size of
        Small ->
            "500px"

        Medium ->
            "640px"

        Big ->
            "1024px"
