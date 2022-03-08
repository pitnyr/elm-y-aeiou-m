# Feature: Implement basic idea of Haskell intro in Elm

Goal: Implement the basic idea of [this Haskell introduction](https://wiki.haskell.org/IO_inside) in Elm.


## Details

I think I'll commit every step, even those that are not working yet.

- [x] [Plain getChar](#plain-getchar)
- [x] [With Int parameter](#with-int-parameter)
- [x] [With Val parameter](#with-val-parameter)
- [x] [Sequence](#sequence)
- [x] [IO type](#io-type)
- [x] [Run in the RealWorld](#run-in-the-realworld)
- [x] [Add putStr](#add-putstr)


<a id="commit-2022-03-07-18-44"></a>

## Plain getChar

To be able to see something in the browser,
we (try to) implement "getChar" slightly differently:
we will not return a character from the user,
but a random (uppercase) character.

[commit-2022-03-07-18-44](https://github.com/pitnyr/elm-y-aeiou-m/commit/ba0b8f06dc224a0092c55e55c7f37a1a84a7d961)
```email
subject: Very first version: getChar : Char

Because Elm only has pure functions, "getChar" currently always
returns the same character.
```


<a id="commit-2022-03-07-18-49"></a>

## With Int parameter

To be able to return different characters,
we have to add a varying input parameter.

[commit-2022-03-07-18-49](https://github.com/pitnyr/elm-y-aeiou-m/commit/39bc5097e38c73808c410c12133480c3b0721f38)
```email
subject: Add manually passed integer: getChar : Int -> Char

We still don't get random resulta: same input -> same output.
```


<a id="commit-2022-03-07-18-58"></a>

## With Val parameter

We introduce a special parameter type.
Because we don't know what should be used here we simply wrap an integer again.

[commit-2022-03-07-18-58](https://github.com/pitnyr/elm-y-aeiou-m/commit/bb2db757f1e8d3e5bd9934bfda94e0f5271d09e0)
```email
subject: Introduce new type: getChar : Val -> Char

Nothing really changes with this commit.
```


<a id="commit-2022-03-07-19-18"></a>

## Sequence

In order to force a certain sequence of the function calls
we additionally return a new "Val" from every function and pass this to the next function call.

[commit-2022-03-07-19-18](https://github.com/pitnyr/elm-y-aeiou-m/commit/59bf621a515ea696e2f62b95ae6cff6ce50dc53a)
```email
subject: Return Val from every function

We pass the "Val" returned from the last function call as input to the
next function call. This guarantees the desired function call sequence.
```


<a id="commit-2022-03-07-20-35"></a>

## IO type

We introduce a new type for the common function signature:
```elm
type alias IO a = Val -> ( a, Val )
```

plus two "monad" functions:
```elm
return : a -> IO a
bind : (a -> IO b) -> IO a -> IO b
```

With these it is possible to hide the passing of the "Val" parameter
from one function call to the next in most of the functions.

We can chain IO function calls with "bind" and return the final result
with "return".

Only the start of the call chains (in function "main") and their end (function "getChar")
have to create a new "Val" value or modify it, respectively.

[commit-2022-03-07-20-35](https://github.com/pitnyr/elm-y-aeiou-m/commit/b5684ac9909e06508c1541833cd19a50ea109878)
```email
subject: Introduce IO type: getChar : IO Char

Introduce two monad functions as well: "bind" and "return".
With these we can build IO function call chains.
```


<a id="commit-2022-03-07-20-59"></a>

## Run in the RealWorld

This change will happen in multiple steps.

First, we transform the "main" program into an IO function (of type "IO (Html msg)").
In order to get the final result,
we create an initial "Val" value, pass it to the main IO function,
and then return the final result, thereby dropping the last "Val" value.

[commit-2022-03-07-20-59](https://github.com/pitnyr/elm-y-aeiou-m/commit/3a7c52918dd90ad4066798b6cf6760844d982ff5)
```email
subject: RealWorld Part 1: mainIO : IO (Html msg)

Transform the "main" program into an IO function and
process it using an initial "Val".
```

<a id="commit-2022-03-07-21-30"></a>

Now we finally want to create real random characters.
In order to do so, we need an initial seed for the random generator.
We want to create the initial seed from the current time.

This means that we need to model our app with "Browser.element".
We don't need flags and messages yet, so both types are just aliases for the Unit type "()".
For the model, we just use the "Val" type.

[commit-2022-03-07-21-30](https://github.com/pitnyr/elm-y-aeiou-m/commit/beee1ff9d3ce953110e1280d463f8737508d12de)
```email
subject: RealWorld Part 2: main : Program () Val Msg

Introduce "Browser.element" to be prepared for finally generating
real random characters.
```

<a id="commit-2022-03-07-21-38"></a>

Next we rename the type "Val" to "World" and change it to be a record.

[commit-2022-03-07-21-38](https://github.com/pitnyr/elm-y-aeiou-m/commit/e0e5f5b3b5663843fc4ade9d8f42752a0969b392)
```email
subject: RealWorld Part 3: main : Program () World Msg

Minor refactoring:
- new name for the "Val" type
- changed it to be a record
```

<a id="commit-2022-03-07-21-53"></a>

Finally, we really generate random characters.
We change the World to contain the seed for the random generator,
initialize it with the current time,
and use the seed to generate random characters.

[commit-2022-03-07-21-53](https://github.com/pitnyr/elm-y-aeiou-m/commit/6e01af20b254d5273a852e15bb02ece75b05d1c8)
```email
subject: RealWorld Part 4: real random characters

The current seed for the random generator is stored in the World.
```


<a id="commit-2022-03-08-11-02"></a>

## Add putStr

By moving to "Browser.Element" we departed from the Haskell code.

What we now have is not beautiful.
I don't like that the "main" program has type "IO (Html msg)".
It is a good example that we can put anything into the IO monad,
and it was an easy way to display the result of the IO program.
But I want to change it.

Looking at the Haskell side, a program there has the type "IO ()".
This means it doesn't return anything.

So how can we produce some output?

For this there is the function "putStr", and we'll implement this in Elm.
We'll store the written output in the model, which is our World type.

[commit-2022-03-08-11-02](https://github.com/pitnyr/elm-y-aeiou-m/commit/ba824410c867ae328a5de3cf8399f31f03e7dd47)
```email
subject: Add putStr : String -> IO ()

The main program now has the type "IO ()", too.
```


## Done

The code doesn't look very nice with the ever increasing indents,
but this will be explored in another feature branch.

Read to be [merged into the main branch](main.md#commit-2022-03-08-11-18).
