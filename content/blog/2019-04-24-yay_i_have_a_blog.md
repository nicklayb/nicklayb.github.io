+++
title = "Yay, I have a blog"

[extra]
tags = ["phoenix", "first"]
+++
Ah, finally. I wanted to start a blog for a year. I tried a lot of things. And I wasn't completely sure what I wanted in the end. I knew I wanted a website where I can show off things and have my own personal website. As a developer, I also wanted to write some code and not use an all-in-one setup.
<!-- more -->
## Trying things 💻

I tried [Medium](https://medium.com/), which I love for reading posts. The editor is pretty interesting, pretty neat and slick. It doesn't have a bunch load of undesired features that bloats the interface. But the fact that the posts are not embeddable on a custom website annoyed me a lot. To have a custom website with a Medium blog, I would have had to link every Medium post manually and I would've forced the user to move to another website.

I also tried Ghost (the [blog platform](https://ghost.org/), not the [metal band](http://ghost-official.com/)). But it turns out that I don't have that much fun with Node and Javascript. I mean, I know them very well, but Javascript is a language I particularly dislike for its lack of typing and static code analysis. Unless you're a human compiler, you have to run Javascript to see if you have any typo or anything. I know that tools exist such as ESLint and Typescript to help write maintainable code. However, Typescript adds a lot of code over Javascript and seems pretty overhead for a simple blog. Don't get me wrong, Javascript is great as a frontend development tool, I know React very well and I love writing React apps. But all the boilerplates that Javascript includes turned me off.

Against my own will, I also tried [Wordpress](https://wordpress.com/). Even though I once was a [Laravel](https://laravel.com/) fanboy and always praise the framework. The thing is that the PHP language is not a fun language to write (unless you use [Laravel](https://laravel.com/)). I think that to write a good PHP app, it has to be completely Object Oriented, otherwise, chances are you'll fall in an unmaintainable pitfall. The language is not consistent at all. You have, for instance, the `strtoupper` function and `str_pad` function that naming does not match. They even named the :: operator a [Paamayim Nekudotayim](https://php.net/manual/en/language.oop5.paamayim-nekudotayim.php). Seriously? I know that the [Wordpress](https://wordpress.com/) solution is maybe, and by far, the most simple. However, I did not have fun trying it. And if I don't have fun, that's a no-go. Since I wanted something maintainable and reliable then I didn't even consider using Ruby on Rails.

## So what? 🤔

Ok so, what are the options? I don't want a SPA since it's only a blog, a React app would be overkill and includes lots of code for nothing that is worth it. But the thing is, I'm really not a fan of server-side rendered application. Why? I don't know, I worked on a lot of server-side rendered app with Javascript dom manipulation that was using the tool-that-shall-not-be-named (jQuery) and these became really unmaintainable. At first, I was thinking of whole markdown editor which stores posts in a database. I tried editors like [Quill](https://quilljs.com/) and a lot of editors built on top of Draft.js, these were cool but not as cool as I wanted them to be. So I thought, what is my favorite markdown editor? Turns out that [Visual Studio Code](https://code.visualstudio.com/) is my bestie.

## Illumination came to me 💡

Why not server-side hosted markdown files? I don't need to have a database. I don't need an online editor. Basically, I don't see why I would need Javascript DOM manipulation for my needs. Then, server-side app will be fine. And after all, it's been a year. Stop derping around wondering about overhead and just do it. **So I did**. I set up an [Elixir](https://elixir-lang.org/) application, server-side rendered and stateless that is serving you what you are reading. I took tools I know and love and just started doing things.

That point to a big problem I have. I have difficulty to switch from "think about things" to "do things". I always want to make sure I have the best technology, the best workflow and the best way of doing things every time.  But I decided to go ahead with this website, I'm sure I have a good technology ([Elixir](https://elixir-lang.org/) is by far one of the most awesome languages I've ever used). I'm sure I have a good workflow (I write posts in [VS Code](https://code.visualstudio.com/) and simply deploy a new version). And I have a good way of doing things (SEO will be easily done with server-side render, and it is safe and fault-tolerant enough for a blog). For now, it perfectly suits the needs.

So it's not the "best", but it's good. If I wouldn't have stopped looking for the "best", I would still have nothing.

My name is Nicolas Boisvert, and welcome to my blog 🙂.
