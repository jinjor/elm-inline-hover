module InlineHover exposing (hover) -- where

{-| Wrap any elements defined in [Html](http://package.elm-lang.org/packages/elm-lang/html/1.0.0/Html)
# Make Special Elements
@docs hover
-}

import Html exposing (text, node, Html, Attribute)
import Html.Attributes exposing (attribute)
import String
import Char


{-| Make a special element that can notice hover state.
```
main =
  ul []
    [ hover styles li [] [ text "Hello" ]
    , hover styles li [] [ text "World" ]
    ]

styles =
  [("background", "#abd")]
```
-}
hover
   : List (String, String)
  -> (List (Attribute msg) -> List (Html msg) -> Html msg)
  -> List (Attribute msg)
  -> List (Html msg)
  -> Html msg
hover styles tag attrs children =
  let
    s =
      String.join ";" <|
        List.map (\(key, value) -> key ++ ":" ++ value ++ " !important") styles

    enter =
      attribute "onmouseenter" <| String.join ";" <| List.map enterEach styles

    leave =
      attribute "onmouseleave" <| String.join ";" <| List.map leaveEach styles

  in
    tag
      ([ enter, leave] ++ attrs)
      children


toCamelCase : String -> String
toCamelCase s =
  String.fromList <|
  List.reverse <|
  snd <|
    List.foldl (\c (cap, memo) ->
      if c == '-' then
        (True, memo)
      else if cap then
        (False, Char.toUpper c :: memo)
      else
        (False, c :: memo)
      ) (False, []) (String.toList s)


enterEach : (String, String) -> String
enterEach (key, value) =
  let
    keyCamel = toCamelCase key
  in
    "this.setAttribute('data-hover-" ++ key ++ "', this.style." ++ keyCamel ++ "||'');" ++
    "this.style." ++ keyCamel ++ "='" ++ value ++ "'"


leaveEach : (String, String) -> String
leaveEach (key, value) =
  let
    keyCamel = toCamelCase key
  in
    "this.style." ++ keyCamel ++ "=this.getAttribute('data-hover-" ++ key ++ "')||'';"
