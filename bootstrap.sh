#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "[1/4] Installing Homebrew deps (git, stow if missing)..."
if ! command -v brew >/dev/null; then
  echo "Homebrew not found. Install it from https://brew.sh and rerun." >&2
  exit 1
fi
brew list git >/dev/null 2>&1 || brew install git
brew list stow >/dev/null 2>&1 || brew install stow

echo "[2/4] Stowing dotfiles..."
cd "$DOTFILES_DIR"
stow -v zsh brew git starship -t "$HOME" || true

echo "[3/4] Installing Brewfile packages..."
brew bundle --file "$DOTFILES_DIR/brew/.Brewfile" || true

echo "[4/4] Reloading shell..."
exec zsh -l
