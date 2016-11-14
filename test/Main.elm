import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import InlineHover exposing (hover)

main =
  beginnerProgram { model = 0, update = update, view = view }

update n _ =
  n

view model =
  ul []
    [ hover hoverStyle li [ style normalStyle, onMouseEnter 1, onMouseLeave 0 ] [ text "Hello" ]
    , hover hoverStyle li [ style normalStyle, onMouseEnter 2, onMouseLeave 0 ] [ text "World" ]
    , li [] [ text (toString model )]
    ]

hoverStyle =
  [ ("background-color", "#abd")
  , ("font-weight", "bold")
  , ("undefined-style", "foo")
  , ("123", "456")
  , ("'", "")
  , ("\"", "")
  , ("---", "")
  , ("=", "")
  , ("font-family", "\"游ゴシック\", \"Yu Gothic\", sans-serif;")
  , ("color", "'")
  , ("color", "\'")
  ]

normalStyle =
  [ ("background-color", "#edc")
  , ("color", "green")
  ]
