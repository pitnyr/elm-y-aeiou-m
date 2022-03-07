module Main exposing (main)

import Html as H


main : H.Html msg
main =
    H.div []
        [ H.text <| "get2Chars: " ++ get2Chars (Val 1) (Val 2)
        , H.br [] []
        , H.text <| "nowOrLater: " ++ nowOrLater (Val 0)
        ]


type Val
    = Val Int


{-| Goal: return a random uppercase character

Currently the character is only dependent on the given parameter value.

-}
getChar : Val -> Char
getChar (Val code) =
    Char.fromCode (Char.toCode 'A' + modBy 26 code)


get2Chars : Val -> Val -> String
get2Chars val1 val2 =
    String.fromChar (getChar val1) ++ String.fromChar (getChar val2)


nowOrLater : Val -> String
nowOrLater val =
    case getChar val of
        'Y' ->
            "Now"

        _ ->
            "Later"
