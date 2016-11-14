module InlineHover exposing (hover)

{-| Wrap any elements defined in [Html](http://package.elm-lang.org/packages/elm-lang/html/1.0.0/Html)
# Make Special Elements
@docs hover
-}

import Html exposing (text, node, Html, Attribute)
import Html.Attributes exposing (attribute)
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
    validStyles =
      List.filter (\(k, v) -> isValidKey k) styles

    enter =
      attribute "onmouseenter" <| String.join ";" <| List.map enterEach validStyles

    leave =
      attribute "onmouseleave" <| String.join ";" <| List.map leaveEach validStyles

  in
    tag
      (enter :: leave :: attrs)
      children


toCamelCase : String -> String
toCamelCase s =
  String.fromList <|
  List.reverse <|
  Tuple.second <|
    List.foldl (\c (cap, memo) ->
      if c == '-' then
        (True, memo)
      else if cap then
        (False, Char.toUpper c :: memo)
      else
        (False, c :: memo)
      ) (False, []) (String.toList s)


isValidKey : String -> Bool
isValidKey s =
  s /= "" &&
  List.any Char.isLower (String.toList s) &&
  List.all (\c -> Char.isLower c || c == '-') (String.toList s)


isValidChars : List Char -> Bool
isValidChars list =
  case list of
    head :: tail ->
      if Char.isLower head || head == '-' then
        isValidChars tail
      else
        False

    _ ->
      True


enterEach : (String, String) -> String
enterEach (key, value) =
  let
    keyCamel = toCamelCase key
    escapedValue = (String.join "\"" << String.split "'") value
  in
    "this.setAttribute('data-hover-" ++ key ++ "', this.style." ++ keyCamel ++ "||'');" ++
    "this.style." ++ keyCamel ++ "='" ++ escapedValue ++ "'"


leaveEach : (String, String) -> String
leaveEach (key, value) =
  let
    keyCamel = toCamelCase key
  in
    "this.style." ++ keyCamel ++ "=this.getAttribute('data-hover-" ++ key ++ "')||'';"
