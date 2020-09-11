# LUG Rice

union(form, function) != emptyset

1. Transparency

    - inspiration: transparency is just plain cool and exists in limited fashion
      in Windows and macOS
    - form: looks cool
    - function: really obvious what the active window is
    - let's me see my wallpaper (see 2)

    how to do this?

    picom

    config here:
    https://git.sr.ht/~sumner/dotfiles/tree/master/dot_config/picom/picom.conf

2. Dynamic Wallpaper

    - inspiration: macOS dynamic wallpapers
    - form: looks cool
    - function: responds to the time of day so I'm not blinded in the middle of
      the night

    script here:
    https://git.sr.ht/~sumner/dotfiles/tree/master/bin/executable_set_wallpaper.sh

3. i3status-rust

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
