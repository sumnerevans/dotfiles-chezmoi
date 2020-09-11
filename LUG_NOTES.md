# LUG Rice

union(form, function) != emptyset

You can have both form and function, they are not mutually exclusive. I don't
really have anything that is just "eye candy for eye candy's sake", pretty much
everything that I do to customize my setup also has a functional aspect.

1. ## Transparency

   ![Transparency](https://git.sr.ht/~sumner/dotfiles/blob/master/images/transparency.png)

   - inspiration: transparency is just plain cool and exists in limited fashion
     in Windows and macOS
   - form: looks cool
   - function: really obvious what the active window is
   - let's me see my wallpaper (see 2)

   how to do this?

   picom

   config here:
   https://git.sr.ht/~sumner/dotfiles/tree/master/dot_config/picom/picom.conf

2. ## Dynamic Wallpaper

   ![Dynamic Wallpaper](https://git.sr.ht/~sumner/dotfiles/blob/master/images/dynamic-wallpaper.png)

   - inspiration: macOS dynamic wallpapers
   - form: looks cool
   - function: responds to the time of day so I'm not blinded in the middle of
     the night

   script here:
   https://git.sr.ht/~sumner/dotfiles/tree/master/bin/executable_set_wallpaper.sh

3. ## i3status-rust

   I use i3wm and i3bar for my window manager and status bar. Then I use
   i3status-rust to display useful information.

   ![i3status-rust](https://git.sr.ht/~sumner/dotfiles/blob/master/images/i3status-rust.png)

   - form: it looks pretty cool
   - function: I use every single one of the things up there at least a few
     times every week
     - A bunch of useful toggles
       - Easy statistics about email
       - Music play/pause
       - Toggles for VPNs
       - IP address and ping
       - volume and switching which device audio is playing from
       - Time
       - Do not Disturb (inspired by DnD in other desktops)

   config here:
   https://git.sr.ht/~sumner/dotfiles/tree/master/dot_config/i3/status.toml.tmpl
