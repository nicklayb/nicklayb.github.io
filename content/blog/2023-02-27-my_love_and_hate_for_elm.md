+++
title = "My love and hate for Elm"
draft = true

[extra]
tags = ["elm", "engineering", "functional"]
+++

What to say about [Elm](https://elm-lang.org)? At the same time such a delightful language but at the same time a worrying one. I cannot really explain clearly why I love/hate this language. But sure thing, it's a language that helps me reason about problems.

<!-- more -->

## **Love**; The syntax

Elm's syntax is, as the language itself describes it; delightful. It truly is. It can look scary at first if your experience doesn't include Haskell or functional programming language (I'm talking _actual_ functional languages, not multi paradigms like JavaScript). I see it as a nice introduction to Haskell has it borrows a lot of it concept but also drop some (more on that later). My favorite features of the language's syntax are the following

### Curried functions by default 

What doesn't seem intuitive about the language is the fact that functions are curried by default. That means that the functions are actually taking only one argument at a single time and might return other 1-argument functions if it needs more parameter. Have the following example:

```elm
type Color
    = Red
    | Blue
    | Green

isSameColor : Color -> Color -> Boolean
isSameColor left right = 
    case (left, right) of
        (Red, Red) -> True
        (Blue, Blue) -> True
        (Green, Green) -> True
        _ -> False
```

The function `isSameColor` is not really a 2-arguments function, it's a 1-argument function that returns a 1-argument function that returns a boolean value. Meaning that you can call it a few different ways

```elm
isBlue : Color -> Boolean
isBlue color =
    isSameColor Blue color
```

The above example calls `isSameColor` with only the first argument creating a new function that takes one argument but Blue baked in.


## **Hate**; The authoritarian synex

## **Love**; Haskell but without the complicated stuff

## **Hate**; Haskell but without the extensible stuff

## **Love**; It's productive even though it might not look like it

## **Hate**; The community

