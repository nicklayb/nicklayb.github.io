+++
title = "Understanding structs in Elixir"
draft = true

[extra]
tags = ["elixir", "struct", "functional", "erlang"]
+++

I've been doing Elixir for around 7 years pretty extensively. Yes, I've used it professionally but I also used it a lot personally. One of the things I love the most are the **structs**. They help me believe and pretend that Elixir is typed (lol).

<!-- more -->

Structs are just wonderful, they give so many compile security and safety, it makes the code super trustable. But have you noticed I said "compile" time? That's because at runtime, structs aren't an actual thing...

## Erlang foundation

If you work with Elixir already, you're likely aware that in the end, Elixir compiles down to BEAM byte code and runs on the BEAM vm. That means it has some limitations. Structs is not a concept that exists in Erlang, all "complex" structures you have are lists, maps, tuple and records. 

Records aren't struct, they are simply tuples with positioned field on top of a tuple. If you have a `:user` with `:email` and `:name` field, in the end it's just a `{:user, "some email", "some name"}`. It has no relation with a struct.

## So what are structs?

Structs are just maps. You might think "of course?", but what I mean is that, it's really just that, in every aspect.

A struct is just a map with a secret key called `__struct__`.

```elixir
defmodule MyStruct do
  defstruct [:name]
end

# The following evaluates to true because, after compile time, this is what the struct becomes.
%MyStruct{name: "Name"} == %{__struct__: MyStruct, name: "Name"} # true
```

All the compile time validation you have are just this, compile time validation. Extremely useful validations, but only at compile time. Example:

```elixir
defmodule User do
  defstruct [:email, :name]

  def put_email(%User{} = user, email) do
    %User{user | email: email}
  end

  def put_age(%User{} = user, age) do
    %User{user | age: age}
  end
end
```

The module above **will not compile**. It will raise because we're updating a `age` key on a struct that doesn't have a `age` field. Extremely useful to avoid typos. I see a lot of people not caring about those and do the following instead

```elixir
defmodule User do
  defstruct [:email, :name]

  def put_age(%{} = user, age) do
    %{user | age: age}
  end
end
```

The above **will compile** but will raise at runtime. It's gonna raise because the `|` operator **updates** a field, it need to already exist. Therefore, a `KeyError` will be raised.

One could just use a `Map.put/3` call instead to make that work. But that kinds of defeat the purpose of structs.

This means it can have some caveats as an application grow if you haven't been careful with how you handled your structs.

## What caveats?

At the company I work, we use Event Sourcing where each of our events are structs, that means persist those in a database in binary form.


