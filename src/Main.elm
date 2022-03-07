module Main exposing (main)

import Html as H


main : H.Html msg
main =
    let
        ( fourChars, _ ) =
            get4Chars (Val 1)

        ( when, _ ) =
            nowOrLater (Val 0)
    in
    H.div []
        [ H.text <| "get4Chars: " ++ fourChars
        , H.br [] []
        , H.text <| "nowOrLater: " ++ when
        ]


type Val
    = Val Int


{-| Goal: return a random uppercase character

Currently the character is only dependent on the given parameter value.

-}
getChar : Val -> ( Char, Val )
getChar (Val code) =
    ( Char.fromCode (Char.toCode 'A' + modBy 26 code)
    , Val (code + 1)
    )


get2Chars : Val -> ( String, Val )
get2Chars val0 =
    let
        ( a, val1 ) =
            getChar val0

        ( b, val2 ) =
            getChar val1
    in
    ( String.fromChar a ++ String.fromChar b
    , val2
    )


get4Chars : Val -> ( String, Val )
get4Chars val0 =
    let
        ( a, val1 ) =
            get2Chars val0

        ( b, val2 ) =
            get2Chars val1
    in
    ( a ++ b
    , val2
    )


nowOrLater : Val -> ( String, Val )
nowOrLater val0 =
    case getChar val0 of
        ( 'Y', val1 ) ->
            ( "Now", val1 )

        ( _, val1 ) ->
            ( "Later", val1 )
