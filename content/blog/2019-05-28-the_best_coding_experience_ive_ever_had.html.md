+++
title = "The best coding experience I ever had"
description = """
I can't really tell in which mood I am. To be honest it's like being in trance for the last 3 days. I woke up wanting to code on my project, I ate thinking about how I want things to be and I fell asleep reasoning on how I will implement my features the next day. I never felt this way about developing apps and I think I finally discovered why. I'm using great tools.
"""

[extra]
tags = ["phoenix", "elixir", "liveview"]
+++
I can't really tell in which mood I am. To be honest it's like being in trance for the last 3 days. I woke up wanting to code on my project, I ate thinking about how I want things to be and I fell asleep reasoning on how I will implement my features the next day. I never felt this way about developing apps and I think I finally discovered why. I'm using great tools.

## Being as productive as possible 🔥

At the office, I was selected to kickstart our new product that uses text messages. Fair enough, I never did this before but with the tools that exist today, it shouldn't be that hard. They trusted me on the tool selection for the app, and that may have been a game changer. I started by asking myself: "What slows me down while developing?" and I came up with the following remarks:

- Trial and error
- DOM manipulation
- Polling API from frontend
- Responding correctly to that frontend

Trial and error might seem "avoidable" when you're used to TDD, however, my delays are short and I have to ship a working version ASAP. No time for the moment for unit tests, so I will have to do trial and error. I have backend development experience with [Ruby on Rails](https://rubyonrails.org/), [Laravel](https://laravel.com/), and [Elixir](https://elixir-lang.org/). Since Elixir is the only one that is compiled, that reduces a **huge** load of trial and error. It's also a tool of choice because it surpasses the two other frameworks on every aspect such as performance, maintainability, and productivity. Thus, it's functional programming which is, in my honest opinion, easier to reason about.

DOM manipulation has always been cringy for me. This is something I hate the most about web development. I did a lot of [jQuery](https://jquery.com/) (which I call _spaghettiQuery_) app back then and I seriously hate most of them. Maybe it exists a maintainable way to work with, but I would be really surprised. I started writing [React](https://reactjs.org/) application a long time ago and I really love it. But it might not be suitable for my use case since it implies a lot of backend/frontend interactions and the project scope is pretty small.

By Polling API from the frontend, I mean like fetching data with an AJAX request. Not that it's hard or long or whatever but you have to double the work as you have to format it in an understandable way and understand it. By working with React, for instance, I would have to try out packages or implement a lot of things on my own to communicate with the backend and I would have to try out packages or implement a lot of things on the backend to answer the frontend **plus** the business logic.

## Gettings the right tool for the right job 🔧

Now that I know what I want to avoid, what exists? What can solve most of the point I mentioned? If you're familiar with the Elixir / Phoenix ecosystem you might already have an answer for me: [Phoenix LiveView](https://dockyard.com/blog/2018/12/12/phoenix-liveview-interactive-real-time-apps-no-need-to-write-javascript).

> LiveWhat? 🤔

Phoenix LiveView's have been developed by [Chris McCord](https://twitter.com/chris_mccord) (creator of [Phoenix](https://phoenixframework.org/)) as a new way to think about rich user experience. It uses the PubSub power of Phoenix to establish a two way binding of view between the server and the client using web sockets. This means that you can write server-side rendering pages that rerender on the client. Say that again but slowly: You write server-side views that rerender on the client. Awesome isn't it?

It avoids trial and error due to Elixir and [Erlang](https://www.erlang.org/) type system and syntax analysis. It avoids DOM manipulation, it does all the things for you. You don't have to wonder about exchanges between server and client since the server does everything.

### About compiled language 📦

Before on, I learned a functional frontend programming language called [Elm](https://elm-lang.org/). This is another language that brought me such pleasure to write. The Elm compiler is not only a compiler but an assistant, it tells you, before you even noticed, that what you wrote might or will crash. **That** is awesome.

Which leads to wondering, what are the pros of interpreted languages? The only reason I can see is that we **need** them. You cannot write frontend application without Javascript. Sadly, Elm is only an abstraction over Javascript, every Elm line is compiled to Javascript.

I dream of a world where browsers can handle lower level code (such as [WebAssembly](https://webassembly.org/)) and we can write Elm or Elixir directly to write frontend application.

## That's cool, but what makes it so productive?

The whole Phoenix frameworks already have everything for binding changesets to forms. All you have to do is "refresh" it on change instead of having _spaghettiQuery_ firing loads of events to update your DOM. Here is an example:

Let's say you have a registration form with the following inputs: First name, last name, email, password and password confirmation. Of course, the first step is to ensure that your backend is as secure as possible. So you write validation in your changeset on the server to ensure that:

- All the fields are required
- The email has an email format and is unique
- Passwords are equals and have a length greater than 6

Phoenix already has a way to give you errors when these requirements are not met. So, on submit, you'll see the error messages on the view. The thing is that, in 2019, you want these validations to be live. If you type an email address that is used,  you don't want a whole submit of the form to know that it is taken. To do so, you need client side validations.

In Javascript, you would use a validation library or create your own and bind events on input changes that check if the rules are met. If not, you update the DOM to display error messages. So you have to rewrite rules in Javascript, bind events, rewrite error messages and you have to handle the wonder world of browser's differences.

With a LiveView, you would run the changeset and rerender. That's all. An event is sent to the server with the new form state, the changeset is updated and what has changed is updated.

It took **0 line of Javascript** to implement asynchronous paginated data tables. It took **0 line of Javascript** to have a real-time experience. It's not only easy to work with, but it's also fun to work with.

## In the end 💆‍♂️

After this, I've been able to build a whole app that is real-time and live in about 3 days. No, it's not tested yet, but it leaves me enough time to secure the hell out of this and setup maintainability tools and do good quality assurance.

Elixir, Phoenix, LiveView, and Ecto are now my new best friends.
