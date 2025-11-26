#!/bin/bash
echo "Setting up config files"
ln -s "${PWD}./.zshrc" "${HOME}/.zshrc"
ln -s "${PWD}/.config/nvim" "${HOME}/.config/nvim"
ln -s "${PWD}/.config/lf" "${HOME}/.config/lf"
ln -s "${PWD}/.config/gitui" "${HOME}/.config/gitui"
ln -s "${PWD}/.config/gh" "${HOME}/.config/gh"
ln -s "${PWD}/.config/wezterm" "${HOME}/.config/wezterm"
ln -s "${PWD}/.config/gh-dash" "${HOME}/.config/gh-dash"
ln -s "${PWD}/.config/ohmyposh" "${HOME}/.config/ohmyposh"
ln -s "${PWD}/.config/ghostty" "${HOME}/.config/ghostty"
ln -s "${PWD}/.config/starship.toml" "${HOME}/.config/starship.toml"

# custom aliases
aliases=(
    "lsi=\"logo-ls -1\""
    "gotest=\"go test -v -run Test\""
    "gs=\"git status -s\""
    "prune=\"docker system prune --all --volumes\""
    "dash=\"gh dash\""
    "gitui=\"gitui -t tokyonight_storm.ron\""
    "tree-add=\"git worktree add \$@\""
    "curl=\"curl \$@\" | jq"
    "tree-remove=\"git worktree remove \$@ --force\""
    "gitlog=\"git log --all --decorate --oneline --graph --pretty=format:'%C(auto)%h%Creset - %C(bold blue)%an%Creset, %Cgreen%ar%Creset : %s' --abbrev=7\""
    "hfzf=\"history | fzf --tac --literal\""
    "cat=bat"
)

zshrc="$HOME/.zshrc"
for alias in "${aliases[@]}"; do
  if  ! grep -q "$alias" "$zshrc"; then
      echo -e "\n$alias" >> "$config_file"
      echo "alias" "$alias" >> "$zshrc"
  fi
done

echo "In progress"
echo "Config files done!"

echo "Installing brew packages"
brew install git buf k9s kubernetes-cli make ninja cmake automake protobuf protolint ripgrep sqlc gitui gh fzf zoxide bat curlie jq yq jnv tlrc atuin
echo "Configuring gh"
gh extension install dlvhdr/gh-dash
echo "Installing npm packages"
sudo npm install -g typescript-language-server vscode-langservers-extracted dockerfile-language-server-nodejs
echo "Installing protols"
cargo install protols
echo "Done!"
