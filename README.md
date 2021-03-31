# Sumner's Dotfiles

```
.----------------------------------------------------------------------------.
|                             DEPRECATION WARNING                            |
|                                                                            |
| I have migrated all of my configuration over to Nix Home Manager. I am no  |
| longer maintaining my dotfiles via this repository anymore.                |
|                                                                            |
| You can find my home manager configuration repository here:                |
| https://git.sr.ht/~sumner/home-manager-config                              |
'----------------------------------------------------------------------------'
```

See my [notes from a LUG presentation I gave on 2020-09-10](https://git.sr.ht/~sumner/dotfiles/tree/master/LUG_NOTES.md)

My dotfiles are managed by [chezmoi](https://github.com/twpayne/chezmoi/).

**Old Dotfile Repos:**

* https://gitlab.com/sumner/dotfiles
* https://gitlab.com/sumner/dotfiles-old

## Installation

```
.----------------------------------------------------------------------------.
| WARNING:                                                                   |
|                                                                            |
| Don't install somebody else's dotfiles. Use them as inspiration, but don't |
| actually just blindly copy.                                                |
'----------------------------------------------------------------------------'
```

To install my dotfiles, use the following `chezmoi` command:

    chezmoi init --apply --verbose git@git.sr.ht:~sumner/dotfiles

## TMPFS

I create a few `tmpfs` on my filesystem. I use `~/tmp` as my personal temporary
folder. I dump downloads there (copy them out if I want to keep it for longer),
I also use it as a playground. Both `~/.cache` and `/var/cache/pacman/pkg` are
just caches, and I really don't want stuff stored there staying on my filesystem
for a long time.

Here's my `/etc/fstab`:

    # tmpfs for ~/tmp, ~/.cache, /var/cache/pacman/pkg
    tmpfs			/home/sumner/tmp	tmpfs	rw,nodev,nosuid,size=32G	0	0
    tmpfs			/home/sumner/.cache	tmpfs	rw,nodev,nosuid,size=32G	0	0
    tmpfs			/var/cache/pacman/pkg	tmpfs	rw,nodev,nosuid,size=32G	0	0

## Notes

I use NeoVim instead of Vim now. The old Vim config has not been updated in a
while.

## Links to the Most Interesting Dotfiles

- My `.zshrc`: https://git.sr.ht/~sumner/dotfiles/tree/master/dot_zshrc
- My NeoVim config: https://git.sr.ht/~sumner/dotfiles/tree/master/dot_config/nvim/init.vim
- My i3 config: https://git.sr.ht/~sumner/dotfiles/tree/master/dot_config/i3/config
- My `i3status-rust` config: https://git.sr.ht/~sumner/dotfiles/tree/master/dot_config/i3/status.toml.tmpl
- My `muttrc`: https://git.sr.ht/~sumner/dotfiles/tree/master/dot_mutt/muttrc
- My quotesfile: https://git.sr.ht/~sumner/dotfiles/tree/master/dot_mutt/quotes
- My `offlineimap` config: https://git.sr.ht/~sumner/dotfiles/tree/master/dot_offlineimaprc

## License

All of these dotfiles are licensed under the Unlicense. See the
[LICENSE](https://git.sr.ht/~sumner/dotfiles/tree/master/LICENSE) file.
