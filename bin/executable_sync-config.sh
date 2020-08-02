#! /usr/bin/env sh
#
# sync-config.sh
#
# Synchronizes the config with dotfiles, deletes the local copy, and then
# symbolic links it.

echo "Moving $1 to ~/dotfiles"
mv "$HOME/$1" "$HOME/dotfiles/"

echo "Linking $1 from ~/dotfiles"
ln -s "$HOME/dotfiles/$1" "$HOME/$1"

echo "Adding $1 to ~/dotfiles/setup/sym-link-list"
echo "$1" >> $HOME/dotfiles/setup/sym-link-list
