Sumner's Dotfiles
=================

Managed using chezmoi_. My old dotfile repo is here:
https://gitlab.com/sumner/dotfiles-old.

.. _chezmoi: https://github.com/twpayne/chezmoi/

See also my scripts: https://gitlab.com/sumner/scripts. I put them into
``~/bin``.

Installation
------------

.. warning::

  Don't install somebody else's dotfiles. Use them as inspiration, but don't
  actually just blindly copy.

To install my dotfiles, use the following ``chezmoi`` command::

    chezmoi init --apply --verbose https://gitlab.com/sumner/dotfiles.git

TMPFS
-----

I create a few ``tmpfs`` on my filesystem. I use ``~/tmp`` as my personal
temporary folder. I dump downloads there (copy them out if I want to keep it for
longer), I also use it as a playground. Both ``~/.cache`` and
``/var/cache/pacman/pkg`` are just caches, and I really don't want stuff stored
there staying on my filesystem for a long time.

Here's my ``/etc/fstab``::

    # tmpfs for ~/tmp, ~/.cache, /var/cache/pacman/pkg
    tmpfs			/home/sumner/tmp	tmpfs	rw,nodev,nosuid,size=32G	0	0
    tmpfs			/home/sumner/.cache	tmpfs	rw,nodev,nosuid,size=32G	0	0
    tmpfs			/var/cache/pacman/pkg	tmpfs	rw,nodev,nosuid,size=32G	0	0

Notes
-----

I use NeoVim instead of Vim now. The old Vim config has not been updated in a
while.

License
-------

All of these dotfiles are licensed under the Unlicense. See the
[LICENSE](./LICENSE) file.
