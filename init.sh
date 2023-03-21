#!/bin/bash
echo "Setting up config files"
ln -s "${PWD}/.wezterm.lua" "${HOME}/.wezterm.lua"
ln -s "${PWD}/starship.toml" "${HOME}/.config/starship.toml"
ln -s "${PWD}/.config/nvim" "${HOME}/.config/nvim"
ln -s "${PWD}/.config/lf" "${HOME}/.config/lf"
echo "In progress"
echo "Config files done!"

echo "Clone wallpapers in ${HOME}"
git clone https://github.com/rose-pine/wallpapers.git ${HOME}/wallpapers
echo "Wallpapers cloned!"

echo "Installing brew packages"
brew install buf helix k9s kubernetes-cli make ninja cmake automake protobuf protolint ripgrep sqlc
echo "Done!"
