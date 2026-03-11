##############################################
# ~/.zshrc — Development-focused configuration
# Optimized for: Homebrew + pyenv + nvm + pipx
# This file is structured in clearly labeled sections.
##############################################

##############################################
# 0) Shell options & history
##############################################
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS SHARE_HISTORY HIST_REDUCE_BLANKS

##############################################
# 1) Homebrew initialization (Apple Silicon friendly)
# - Ensures brew and its paths are available early
# - Do this ONCE (avoid duplicate shellenv calls)
##############################################
if [[ -d /opt/homebrew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

##############################################
# 2) Python version management via pyenv
# - No Brew Python needed; pyenv provides shims for python/pip
# - pyenv-virtualenv auto-activates per project
##############################################
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"            # adds shims so 'python'/'pip' resolve via pyenv

# Optional: auto-activate virtualenvs when a .python-version is present
if command -v pyenv-virtualenv-init >/dev/null; then
  eval "$(pyenv virtualenv-init -)"
fi

##############################################
# 3) Python UX defaults
# - Prevent accidental global installs; prefer venvs/pipx
##############################################
export PIP_DISABLE_PIP_VERSION_CHECK=1
export PIP_NO_PYTHON_VERSION_WARNING=1
export PIP_REQUIRE_VIRTUALENV=true
# Emergency lever: allow one-off global pip with `pip! install ...`
alias pip!='PIP_REQUIRE_VIRTUALENV="" pip'

##############################################
# 4) pipx for global Python-backed CLIs (black, ruff, httpie, etc.)
##############################################
# `brew install pipx && pipx ensurepath` will place binaries in ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"

##############################################
# 4a) Editor defaults
##############################################
export EDITOR="code --wait"
export VISUAL="$EDITOR"

##############################################
# 5) direnv (per-project environment variables)
##############################################
if command -v direnv >/dev/null; then
  eval "$(direnv hook zsh)"
fi

##############################################
# 6) Node.js via nvm (installed via Homebrew)
# - Loads nvm from the Homebrew prefix if available
##############################################
export NVM_DIR="$HOME/.nvm"
if command -v brew >/dev/null; then
  if [[ -s "$(brew --prefix nvm)/nvm.sh" ]]; then
    . "$(brew --prefix nvm)/nvm.sh"
  fi
  if [[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ]]; then
    . "$(brew --prefix nvm)/etc/bash_completion.d/nvm"
  fi
fi

##############################################
# 7) Java (OpenJDK via Homebrew)
# - Adds OpenJDK bin to PATH if installed
##############################################
if command -v brew >/dev/null && [[ -d "$(brew --prefix)/opt/openjdk" ]]; then
  export PATH="$(brew --prefix)/opt/openjdk/bin:$PATH"
fi

##############################################
# 8) User-local bin directory
##############################################
export PATH="$HOME/bin:$PATH"

##############################################
# 9) Oracle CLI autocomplete (if locally installed)
##############################################
# Dynamic glob — works across any Python version
for _oci_ac in "$HOME"/lib/oracle-cli/lib/python*/site-packages/oci_cli/bin/oci_autocomplete.sh; do
  [[ -f "$_oci_ac" ]] && source "$_oci_ac" && break
done
unset _oci_ac

##############################################
# 11) Helpful helpers
# - mkvenv: create and activate .venv from current pyenv Python
# - rmvenv: remove the local .venv safely
# - usepy: ensure a specific Python version exists and pin it in this repo
##############################################
mkvenv() { python -m venv .venv && source .venv/bin/activate && python -m pip install -U pip wheel; }
rmvenv() { deactivate 2>/dev/null; rm -rf .venv; }
usepy()  { pyenv install -s "$1" && pyenv local "$1" && python -V; }

##############################################
# 10) fzf key bindings and completion (if installed)
##############################################
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

##############################################
# 11) Prompt & readability (colors, glyphs, UX)
# - Starship prompt (fast, cross-shell)
# - zsh-syntax-highlighting (valid cmd = green, invalid = red)
# - zsh-autosuggestions (ghost-text based on history)
# - lsd (colorful ls replacement)
##############################################
# Starship prompt (requires: brew install starship)
if command -v starship >/dev/null; then
  eval "$(starship init zsh)"
fi

# Syntax highlighting (requires: brew install zsh-syntax-highlighting)
if command -v brew >/dev/null && [[ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Autosuggestions (requires: brew install zsh-autosuggestions)
if command -v brew >/dev/null && [[ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# lsd: modern, colored ls (requires: brew install lsd)
# Shows file types (-F) and groups directories first for readability
if command -v lsd >/dev/null; then
  alias ls='lsd -F --group-dirs=first'
fi

##############################################
# 12) Navigation improvements
# - zoxide: smarter cd with frecency
##############################################
if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi

##############################################
# 13) History search (substring with arrow keys)
##############################################
if command -v brew >/dev/null && [[ -f "$(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh" ]]; then
  source "$(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi

# End of file