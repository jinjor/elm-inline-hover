# elm-inline-hover

An utility for using :hover by inline style.


## How to use

Just insert `hover [("whatever", "styles"), ("you", "like")]` before Html nodes.

```elm
main =
  ul []
    [ hover styles li [] [ text "Hello" ]
    , hover styles li [] [ text "World" ]
    ]

styles =
  [("background", "#abd")]
```

That's it :)
