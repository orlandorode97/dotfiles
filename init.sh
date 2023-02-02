#!/bin/bash
echo "Setting up config files"
ln -s "${PWD}/.wezterm.lua" "${HOME}/.wezterm.lua"
ln -s "${PWD}/starship.toml" "${HOME}/.config/starship.toml"
ln -s "${PWD}/dotfiles/.config/nvim" "${HOME}/.config/nvim"
echo "Done!"
