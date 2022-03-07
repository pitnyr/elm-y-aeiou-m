module Main exposing (main)

import Html as H


main : H.Html msg
main =
    H.text get2Chars


{-| Goal: return a random uppercase character

Currently all we can do is to always return the same character...

-}
getChar : Char
getChar =
    'X'


get2Chars : String
get2Chars =
    String.fromChar getChar ++ String.fromChar getChar
