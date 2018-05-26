# DEPRECATED

This library is only available for Elm 0.18 or less.

I'm not going to port this library for 0.19 for some reasons.

- The implementation used in this library is not allowed in 0.19 world.
- This is a kind of hack! (not good for Elm ecosystem in the long run)
- I'm not using this now, just using CSS.

# elm-inline-hover

[![Build Status](https://travis-ci.org/jinjor/elm-inline-hover.svg)](https://travis-ci.org/jinjor/elm-inline-hover)

An utility for using :hover by inline style.


## How to use

Just insert `hover [("whatever", "styles"), ("you", "like")]` before Html nodes.

```elm
import InlineHover exposing(hover)

main =
  ul []
    [ hover styles li [] [ text "Hello" ]
    , hover styles li [] [ text "World" ]
    ]

styles =
  [("background", "#abd")]
```

That's it!


## License

BSD3
