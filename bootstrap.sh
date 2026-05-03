#!/usr/bin/env bash
# ============================================================
# bootstrap.sh — fresh-Mac setup for this dotfiles repo
# Idempotent: safe to re-run on the same machine.
# ============================================================
set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/projects/dotfiles}"
STOW_PACKAGES=(zsh brew git starship claude)
BREWFILE="$DOTFILES/brew/.Brewfile"

log()  { printf "\033[1;34m==>\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33m!! \033[0m %s\n" "$*" >&2; }
die()  { printf "\033[1;31mxx \033[0m %s\n" "$*" >&2; exit 1; }

# ------------------------------------------------------------
# 1. Xcode Command Line Tools (provides git, compiler toolchain)
# ------------------------------------------------------------
log "[1/7] Checking Xcode Command Line Tools..."
if ! xcode-select -p >/dev/null 2>&1; then
  log "Installing Xcode CLT (a GUI prompt will appear)..."
  xcode-select --install || true
  until xcode-select -p >/dev/null 2>&1; do
    sleep 5
    log "Waiting for Xcode CLT install to finish..."
  done
fi

# ------------------------------------------------------------
# 2. Homebrew
# ------------------------------------------------------------
log "[2/7] Checking Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
  log "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Apple Silicon vs Intel brew prefix
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
else
  die "Homebrew install appears to have failed."
fi

# ------------------------------------------------------------
# 3. Minimum tools needed for the rest of bootstrap
# ------------------------------------------------------------
log "[3/7] Ensuring git + stow are present..."
brew list --formula git  >/dev/null 2>&1 || brew install git
brew list --formula stow >/dev/null 2>&1 || brew install stow

# ------------------------------------------------------------
# 4. Sanity-check the dotfiles checkout location
# ------------------------------------------------------------
log "[4/7] Verifying dotfiles checkout at $DOTFILES..."
[[ -d "$DOTFILES/.git" ]] || die "$DOTFILES is not a git checkout. Clone the repo there first."
[[ -f "$BREWFILE"    ]] || die "Brewfile not found at $BREWFILE"

# ------------------------------------------------------------
# 5. Stow dotfile packages into $HOME
# ------------------------------------------------------------
log "[5/7] Stowing packages: ${STOW_PACKAGES[*]} -> $HOME"
cd "$DOTFILES"
for pkg in "${STOW_PACKAGES[@]}"; do
  if [[ -d "$pkg" ]]; then
    stow -v --target="$HOME" --restow "$pkg"
  else
    warn "Skipping missing stow package: $pkg"
  fi
done

# ------------------------------------------------------------
# 6. Install everything in the Brewfile
# ------------------------------------------------------------
log "[6/7] Running brew bundle (this can take a while)..."
brew bundle --file="$BREWFILE"

# ------------------------------------------------------------
# 7. Post-install plumbing for tools that need extra setup
# ------------------------------------------------------------
log "[7/7] Wiring up shell integrations..."

# fzf: generate ~/.fzf.zsh with keybindings + completion (idempotent)
if [[ -x "$(brew --prefix)/opt/fzf/install" && ! -f "$HOME/.fzf.zsh" ]]; then
  log "Installing fzf shell integration..."
  "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
fi

# Claude Code: install via npm if missing (config is stowed from claude/ package)
if command -v node >/dev/null 2>&1 && ! command -v claude >/dev/null 2>&1; then
  log "Installing Claude Code (npm)..."
  npm install -g @anthropic-ai/claude-code
fi

cat <<'POST'

============================================================
 Bootstrap complete.

 Manual next steps:

 SECRETS / API KEYS
   - Create ~/.zshrc.local for machine-local secrets (kept out of git):
       touch ~/.zshrc.local && chmod 600 ~/.zshrc.local
     Add lines like:
       export ANTHROPIC_API_KEY="$(op read 'op://Personal/Anthropic API/credential')"
       export GITHUB_TOKEN="..."
   - 1Password CLI: run `op signin` after signing in to the desktop app.
   - secrets/ is gitignored — provision OCI/AWS/k8s configs out-of-band.

 IDENTITY / AUTH
   - gh auth login                      (GitHub CLI)
   - ssh-keygen -t ed25519 -C ...       (or restore ~/.ssh from backup)
   - Sign into Tailscale via the menu-bar app

 RUNTIMES (rerun for each version you actually need)
   - pyenv install <version>            then `pyenv global <version>`
   - nvm install <version>              then `nvm alias default <version>`
   - rbenv install <version>            then `rbenv global <version>`

 NOT IN BREWFILE (install separately)
   - Bun:      curl -fsSL https://bun.sh/install | bash
   - Bun completions land in ~/.bun and are sourced by .zshrc.

 EDITOR
   - Open VS Code, sign in, enable Settings Sync to pull your settings/keybindings.

 CLAUDE CODE
   - Authenticate:                        claude login
   - First run will auto-install plugins from ~/.claude/settings.json
     (sales@knowledge-work-plugins, open-tax@open-tax-marketplace,
      superpowers@claude-plugins-official). Confirm prompts as they appear.
   - Skills/plugins from those marketplaces auto-restore on first plugin sync —
     they're not committed to the dotfiles repo (too large).

 Restart your shell or run: exec zsh -l
============================================================
POST
