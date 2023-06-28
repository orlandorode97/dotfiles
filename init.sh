#!/bin/bash
echo "Setting up config files"
ln -s "${PWD}/starship.toml" "${HOME}/.config/starship.toml"
ln -s "${PWD}/.config/nvim" "${HOME}/.config/nvim"
ln -s "${PWD}/.config/lf" "${HOME}/.config/lf"
ln -s "${PWD}/.config/gitui" "${HOME}/.config/gitui"
ln -s "${PWD}/.config/gh" "${HOME}/.config/gh"
ln -s "${PWD}/.config/wezterm" "${HOME}/.config/wezterm"
ln -s "${PWD}/.config/gh-dash" "${HOME}/.config/gh-dash"
echo "In progress"
echo "Config files done!"

echo "Installing brew packages"
brew install git buf helix k9s kubernetes-cli make ninja cmake automake protobuf protolint ripgrep sqlc lf gitui gh
echo "Configuring gh"
gh extension install dlvhdr/gh-dash
echo "Done!"
