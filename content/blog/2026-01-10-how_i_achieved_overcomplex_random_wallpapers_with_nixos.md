+++
title = "How I achieved overcomplex random wallpapers with NixOS and Hyprpaper"
draft = false

[extra]
tags = ["nixos", "systemd", "linux", "hyprpapr", "hyprland"]
+++

After daily driving NixOS for around a year, I think I'm starting to understanding the thing. The more I understand it, the more I like it. I've kept on adding new stuff to my systems weekly (I'm saying systems even though I might only have added it to one, but it's NixOS, so they'll have it after fingersnap rebuild).

<!-- more -->

Being on NixOS has a lot, but like **A LOT** of benefits for thinkerer, but I comes with its negative. Which are not actually negatives but more likely a test of your knowledge of the tools you use. I spent a whole day trying to just bootstrap an Elm project with Vite using a template project and never managed to do it. Because I didn't knew how the boilerplate works. It had dependencies that had dependencies that had binaries that had to be NixOS wrapped. I eventually kicked off a new project with ESBuild like I know how, in less than 15 minutes.

When I say it tests your knowledge it is because in order to be able to code in a specific language, you have to configure a nix environment that has what's necessary to code in this language. What I was usually doing in the past with `asdf` on my Mac, I now need to do it in nix but even more precisely. But I'm getting there.

## I'm here for random wallpapers, how?

Enough talking here's how I did it.


### 1. A script that downloads wallpapers from Unsplash

[Unsplash](https://unsplash.com) is a great source of wonderful images (99% of wallpapers are found there), I'm a landscape/space kind of person, Unsplash has me covered. They expose an API allowing you to pull random images based off a query, so that's what I used:


```sh
#!/usr/bin/env sh

QUERY=$1
DESTINATION=$2

API_URL="http://hal.nboisvert.local:7070/photos/random"

RAW_URL=$(curl -G -H "Accept: application/json" --data-urlencode="orientation=landscape" --data-urlencode="query=$QUERY" -s "$API_URL" | jq -r '.urls.raw')

if [ -z "$RAW_URL" ] || [ "$RAW_URL" = "null" ]; then
  echo "Invalid URL"
  exit 1
fi

curl -L "$RAW_URL" -o "$DESTINATION"
```

[source](https://github.com/nicklayb/nixos-config/blob/25.11/modules/desktop_environment/hyprland/pull-wallpaper.sh)

#### What is this URL?

You probably noticed the `API_URL` being `http://hal.nboisvert.local:7070` instead of `https://api.unsplash.com`. Yeah, another overcomplicated bit. Since the random wallpaper setup will be installed on many computers, I didn't want to need my API key. 

So I just built a [Unsplash Proxy](https://github.com/nicklayb/unsplash-proxy) app that forwards all requests to Unsplash inferring the API key. It also have a cache layer preventing me from over calling the API if something happens. I'm fine with the random wallpaper working only on my network. This app is running as a docker container on my server and serving my random wallpapers perfectly!

### 2. Dealing with systemd

One of the most worthful read I had was the [Arch's systemd documentation](https://wiki.archlinux.org/title/Systemd) (can we take a moment to appreciate how amazing Arch's documentation is?). This documentation was so insightful. Systemd is the backbone of how most Linux system works, it's important to understand it.

It helped to understand I would need to feature from systemd: A service (duh!?), and a timer.

Basically, to make it simple, the timer is running just like a cron job but it starts your service unit according to a given timer config. For instance, mine is configured for every 2 hours, 5 minutes after booting.

In my config a requiring a pattern of wallpaper locations plus their corresponding screens. So that I can configure Hyprpaper correctly as well. This is the gist of it:

```nix
{
  config,
  lib,
  pkgs,
  username,
  ...
}:
{
  options = {
    #
    # Here is where the random wallpaper module is configured:
    #
    mods.hyprland = {
      enable = lib.mkEnableOption "Enables Hyprland";
      # Some configs ...
      hyprpaper = {
        randomWallpapers = {
          enable = lib.mkEnableOption "Enables random wallpapers";
          query = lib.mkOption {
            description = "Query to use with Unsplash";
            type = lib.types.str;
          };
          mapping =
            let
              innerMapping = lib.types.submodule {
                options = {
                  wallpaper = lib.mkOption {
                    type = lib.types.str;
                    description = "Wallpaper path";
                  };
                  monitors = lib.mkOption {
                    type = lib.types.listOf lib.types.str;
                    description = "Monitors that shows the wallpaper";
                  };
                };
              };
            in
            lib.mkOption {
              description = "Monitor / wallpaper mapping";
              type = lib.types.attrsOf (lib.types.listOf lib.types.str);
            };
          timerConfig = lib.mkOption {
            description = "Timer to update the wallpapers";
            type = lib.types.attrs;
            default = {
              OnBootSec = "5min";
              OnUnitActiveSec = "2h";
              Persistent = true;
            };
          };
        };
      };
      # Other configs ...
    };
  };
  #
  # Here is how it gets configued
  #
  config = lib.mkIf config.mods.hyprland.enable {
      # Hyprland jibberish ...
      services.hyprpaper =
        let
          randomWallpapers = config.mods.hyprland.hyprpaper.randomWallpapers;
          preloads =
            if randomWallpapers.enable then # These two ifs are there so support static wallpapers as well
              lib.mapAttrsToList (name: value: name) randomWallpapers.mapping
            else
              config.mods.hyprland.wallpapers;

          wallpapers =
            if randomWallpapers.enable then
              lib.concatLists (
                lib.mapAttrsToList (
                  wallpaper: monitors: map (monitor: "${monitor},${wallpaper}") monitors
                ) randomWallpapers.mapping
              )
            else
              config.mods.hyprland.wallpapers;
        in
        {
          enable = true;
          settings = import ./hyprpaper.nix {
            preloads = preloads;
            wallpapers = wallpapers;
          };
        };
      # Even more boring stuff ...
    };
    #
    # Part 1; The Service, the bit that does the work.
    # 
    systemd.user.services.switch-wallpapers =
      lib.mkIf config.mods.hyprland.hyprpaper.randomWallpapers.enable
        {
          description = "Update wallpaper";
          serviceConfig =
            let
              localScript = pkgs.writeShellScript "change-wallpaper" (builtins.readFile ./pull-wallpaper.sh);
              scriptBody = builtins.concatStringsSep "\n" (
                lib.concatLists (
                  lib.mapAttrsToList (wallpaper: monitors: [
                    "${localScript} \"${config.mods.hyprland.hyprpaper.randomWallpapers.query}\" \"${wallpaper}\""
                  ]) config.mods.hyprland.hyprpaper.randomWallpapers.mapping
                )
              );
              script = pkgs.writeShellApplication {
                name = "change-wallpapers";
                runtimeInputs = [
                  pkgs.curl
                  pkgs.jq
                ];
                text = ''
                  #!/usr/bin/env sh
                  ${scriptBody}

                  systemctl restart hyprpaper --user
                '';
              };
            in
            {
              Type = "oneshot";
              ExecStart = "${script}/bin/change-wallpapers";
            };
        };

    #
    # Part 2; The Timer, the bit that calls the service to actually do the work
    #
    systemd.user.timers.switch-wallpapers =
      lib.mkIf config.mods.hyprland.hyprpaper.randomWallpapers.enable
        {
          description = "Update wallpapers automatically";

          timerConfig = config.mods.hyprland.hyprpaper.randomWallpapers.timerConfig;

          wantedBy = [ "timers.target" ];
        };
  };
}
```

[source](https://github.com/nicklayb/nixos-config/blob/25.11/modules/desktop_environment/hyprland/default.nix)

What I like about systemd timers/servicers is the observability you get that is built in and easy to manage. There's a lot of handful command to help you debug it:

- `systemctl --user status switch-wallpapers.service`: Gets the status of the service
- `systemctl --user cat switch-wallpapers.service`: Opens the service file, so you can see how its sources look and if you made any typos (like I did)
- `systemctl --user start switch-wallpapers.service`: Runs the command ad-hoc

(You can replace `switch-wallpapers.service` for `switch-wallpapers.timer`, to do the same on the timer).

### 3. Enabling it

In order for it to work, you gotta enable it (no way?). This is done through the three options outlined above: `enable`, `query` and `mapping`:

- `enable`: Enable random wallpapers, otherwise the module will try to use the static wallpapers options
- `query`: The query you wanna call Unsplash with
- `mapping`: How do you map your monitors to individual wallpaper files.

Example of how it's enabled on my T480s

```nix
randomWallpapers = {
  enable = true;
  query = "mountains";
  mapping = {
    "/home/${username}/.background" = [ "eDP-1" ];
    "/home/${username}/.background-external" = [
      "HDMI-A-2"
      "DP-1"
      "DP-3"
      "DP-4"
    ];
  };
};
```

[source](https://github.com/nicklayb/nixos-config/blob/25.11/hosts/t480s/configuration.nix)

So my logic here is will always use this laptop with either screen + monitor or just monitor. So I mapped one random wallpaper to my laptop screen, and one to my external monitor, whatever that is or however it's connected.

I'm querying mountains wallpaper, I love mountains.

It should be simple as that.

## What's next?

I could certainly do a few improvemments, namely:

- Reorganize the randome wallpaper to its own module, it's already getting quite ugly, so that couldn't hurt.
- Try to find a way to have a transition between change, now it shows the default Hyprland in between.
- Improve the overall config. The mapping can still be used as one source of truth for static wallpaper as well. Maybe the `randomWallpapers` part could just be the enable and query.

That's it. Thanks for reading.
