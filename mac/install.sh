#!/bin/bash
# hobo/mac move-in: symlink configs into place, install tools.
#   ./install.sh              links + brew bundle
#   ./install.sh --links      links only
#   ./install.sh --zerotier   also let zerotier-cli run without sudo (asks for sudo once)
# Existing files are moved aside to <file>.pre-hobo.<timestamp>.
set -euo pipefail
here=$(cd "$(dirname "$0")" && pwd)
ts=$(date +%Y%m%d%H%M%S)

link() {  # link <repo-path> <target>
  src="$here/$1"; dst=$2
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then return; fi
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mv "$dst" "$dst.pre-hobo.$ts"; echo "  saved old $dst -> $dst.pre-hobo.$ts"
  fi
  ln -s "$src" "$dst"; echo "  $dst -> $src"
}

echo "== links"
link ghostty/config.ghostty  "$HOME/.config/ghostty/config.ghostty"
link tmux/tmux.conf          "$HOME/.tmux.conf"
link zsh/zshrc               "$HOME/.zshrc"
link finicky/finicky.js      "$HOME/.finicky.js"
link hobo/zt-probe           "$HOME/.config/hobo/zt-probe"
for f in "$here"/bin/*; do link "bin/$(basename "$f")" "$HOME/.local/bin/$(basename "$f")"; done

echo "== git"
[ -f "$HOME/.gitignore_global" ] || printf '.DS_Store\n' > "$HOME/.gitignore_global"
git config --global core.excludesfile "$HOME/.gitignore_global"

if [ "${1:-}" != --links ]; then
  echo "== brew"
  brew bundle --file="$here/Brewfile"
fi

if [ "${1:-}" = --zerotier ]; then
  echo "== zerotier: copying authtoken so zerotier-cli works without sudo"
  d="$HOME/Library/Application Support/ZeroTier/One"
  mkdir -p "$d"
  sudo cat "/Library/Application Support/ZeroTier/One/authtoken.secret" > "$d/authtoken.secret"
  chmod 600 "$d/authtoken.secret"
fi

if tmux info >/dev/null 2>&1; then tmux source-file ~/.tmux.conf && echo "== reloaded running tmux"; fi

cat <<'MSG'

next:
  * open Finicky once and let it become the default browser
    (System Settings > Desktop & Dock > Default web browser)
  * restart Ghostty (or cmd+shift+, to reload)
MSG
