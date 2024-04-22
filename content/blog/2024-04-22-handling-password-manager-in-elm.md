+++
title = "Handling Password Manager in Elm"

[extra]
tags = ["elm", "password", "manager", "functional"]
+++

I've been running my [Meep](https://meep.games) app for a couple years now and logging all my board games game into it. It has worked fine but one thing was constantly annoying me; I couldn't use 1Password with it. Actually, I could, but I needed to enter each field and add space then remove it to trigger the message dispatch, pretty annoying. Then I saw a friend of mine trying to register with its password manager and failed and I thought, alright, enough.

<!-- more -->

## What's the problem actually?

Why is it not working in the first place? That's pretty simple in the end. Elm doesn't expose a `onChange` (which handles `"change"`) event handler (Why? Go figure...), it only exposes `onInput` (which handles `"input"`). The 1Password extensoin doesn't fire an `"input"` change, it fires a `"change"` so the that's why it doesn't make it to Elm.

## Potential solution

My first solution was to add a JS event handler that would bind `onchange` to a function that would fire to a port and the app would forward the external change to the inside of the app.

I'm sure you thought "Does it needs to be that complicated?" while reading that sentence. It does not, got to [The Solution](#the-solution) if you wanna head straight to the solution. But you can continue reading and see how hard Elm is trying to make it.

So I try that, I add a `Attributes.attribute "onchange" "console.log(event)` just to see if that works. It should right? It does not. Calling `Attributes.attribute` will [prefix the key of the attribute](https://github.com/elm/virtual-dom/blob/962f55501704292d8b2b66695fc1f587b5185ef7/src/Elm/Kernel/VirtualDom.js#L299) with `data-` if you try to add an attribute that is an event handler (Again, why? Go figure).

In the end I needed to call `Elm.Kernel.VirtualDom.attribute "onchange", "console.log(event)"`, to get that working. I was about to work on the port solution until I actually started using my head.

## The Solution


It turns out the solution is far easier and doesn't need any ports. Elm exposes `Html.Events.stopPropagationOn` which allows to bind custom event (like `"change"`). So I just made sure my `Form.input` function had both `onInput` and a custom `onChange` as event handler and the deal is done. See below for the basic gist of it

```elm
module Form exposing (input)

import Html exposing (Html Attribute)
import Html.Events exposing (stopPropagationOn, targetValue)
import Json.Decode

onChange : (String -> msg) -> Attribute msg
onChange tagger =
    -- This is pretty much the same code as the `onInput` function with `"change"` instead
    stopPropagationOn "change" (Json.Decode.map (\x -> ( x, True )) (Json.Decode.map tagger targetValue))

input = msg -> Html msg
input msg = 
    Html.input [ onInput msg, onChange msg ] []
```

No more complicted than that. I know it's simple in the end but I figured it might help some beginners.
