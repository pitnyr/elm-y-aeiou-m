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


type alias IO a =
    Val -> ( a, Val )


return : a -> IO a
return a =
    \val -> ( a, val )


bind : IO a -> (a -> IO b) -> IO b
bind ioa f =
    \val0 ->
        let
            ( a, val1 ) =
                ioa val0

            ( b, val2 ) =
                f a val1
        in
        ( b, val2 )


{-| Goal: return a random uppercase character

Currently the character is only dependent on the given parameter value.

-}
getChar : IO Char
getChar (Val code) =
    ( Char.fromCode (Char.toCode 'A' + modBy 26 code)
    , Val (code + 1)
    )


get2Chars : IO String
get2Chars =
    bind getChar <|
        \a ->
            bind getChar <|
                \b ->
                    return
                        (String.fromChar a ++ String.fromChar b)


get4Chars : IO String
get4Chars =
    bind get2Chars <|
        \a ->
            bind get2Chars <|
                \b ->
                    return
                        (a ++ b)


nowOrLater : IO String
nowOrLater =
    bind getChar <|
        \c ->
            return
                (case c of
                    'Y' ->
                        "Now"

                    _ ->
                        "Later"
                )
