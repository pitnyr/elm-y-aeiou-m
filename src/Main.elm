module Main exposing (main)

import Browser
import Html as H
import Random
import Task
import Time


main : Program () World Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias World =
    { seed : Random.Seed }


type Msg
    = GotCurrentTime Time.Posix


init : () -> ( World, Cmd Msg )
init () =
    -- create initial world
    ( { seed = Random.initialSeed 0 }
    , Task.perform GotCurrentTime Time.now
    )


update : Msg -> World -> ( World, Cmd Msg )
update msg _ =
    case msg of
        GotCurrentTime posix ->
            ( { seed = Random.initialSeed (Time.posixToMillis posix) }
            , Cmd.none
            )


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


getChar : IO Char
getChar world =
    let
        ( code, newSeed ) =
            Random.step (Random.int 0 25) world.seed
    in
    ( Char.fromCode (Char.toCode 'A' + code)
    , { seed = newSeed }
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
