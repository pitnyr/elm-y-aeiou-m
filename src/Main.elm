module Main exposing (main)

import Html as H


main : H.Html msg
main =
    H.div []
        [ H.text <| "get2Chars: " ++ get2Chars
        , H.br [] []
        , H.text <| "nowOrLater: " ++ nowOrLater
        ]


{-| Goal: return a random uppercase character

Currently the character is only dependent on the given parameter value.

-}
getChar : Int -> Char
getChar code =
    Char.fromCode (Char.toCode 'A' + modBy 26 code)


get2Chars : String
get2Chars =
    String.fromChar (getChar 1) ++ String.fromChar (getChar 2)


nowOrLater : String
nowOrLater =
    case getChar 0 of
        'Y' ->
            "Now"

        _ ->
            "Later"
