module Main exposing (main)

import Browser
import Html as H


main : Program () World Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias World =
    { val : Int }


type alias Msg =
    ()


init : () -> ( World, Cmd Msg )
init () =
    -- create initial world
    ( { val = 0 }, Cmd.none )


update : Msg -> World -> ( World, Cmd Msg )
update _ world =
    ( world, Cmd.none )


view : World -> H.Html Msg
view world =
    -- take the current world
    world
        -- pass it to the main IO function
        |> mainIO
        -- get the final result from the ( result, world ) tuple
        |> Tuple.first


subscriptions : World -> Sub Msg
subscriptions _ =
    Sub.none


mainIO : IO (H.Html msg)
mainIO =
    bind get4Chars <|
        \fourChars ->
            bind nowOrLater <|
                \when ->
                    return
                        (H.div []
                            [ H.text <| "get4Chars: " ++ fourChars
                            , H.br [] []
                            , H.text <| "nowOrLater: " ++ when
                            ]
                        )


type alias IO a =
    World -> ( a, World )


return : a -> IO a
return a =
    \world -> ( a, world )


bind : IO a -> (a -> IO b) -> IO b
bind ioa f =
    \world0 ->
        let
            ( a, world1 ) =
                ioa world0

            ( b, world2 ) =
                f a world1
        in
        ( b, world2 )


{-| Goal: return a random uppercase character

Currently the character is only dependent on the given parameter value.

-}
getChar : IO Char
getChar world =
    ( Char.fromCode (Char.toCode 'A' + modBy 26 world.val)
    , { val = world.val + 1 }
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
