#!/usr/bin/env zsh
# Preview the starship prompt in every state without touching your real shell.
# usage: zsh ~/.config/starship-preview.sh
show() {
  local label=$1; shift
  # strip zsh's %{ %} prompt wrappers, and the leading blank line from add_newline
  local out=$(starship prompt "$@" | sed 's/%{//g; s/%}//g' | sed '/^[[:space:]]*$/d')
  printf '  %-24s %s\n' "$label" "$out"
}
print -P "\n\e[1mstarship prompt states\e[0m  (bg should be TokyoNight #1a1b26)\n"
show "success  exit 0"        --status 0
show "ERROR    exit 1"        --status 1
show "ERROR    exit 127"      --status 127
show "slow cmd 3.2s"          --status 0 --cmd-duration 3200
show "right prompt / clock"   --right
print ""
