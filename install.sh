#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
PACKAGES="zsh vim tmux"

echo "Installing prerequisites…"
case "$(uname)" in
  Darwin)
    command -v brew >/dev/null || \
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install zsh tmux fzf stow
    ;;
  Linux)
    sudo apt update
    sudo apt install -y zsh tmux fzf stow
    ;;
esac

cd "$DOTFILES"
for pkg in $PACKAGES; do
  stow -D "$pkg" 2>/dev/null || true
  stow "$pkg"
done

echo "Done! Restart your shell."

