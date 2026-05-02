# ===========================================
# Homebrew Bundle — consolidated laptop setup
# Single source of truth (managed via dotfiles)
# ===========================================

# ---------- Taps ----------
tap "hashicorp/tap"

# ---------- Core CLI & Utilities ----------
brew "oci-cli"             # Oracle Cloud Infrastructure CLI
brew "ansible"             # automation/configuration management
brew "awscli"              # AWS CLI
brew "bat"                 # colorful cat
brew "btop"                # modern system monitor
brew "direnv"              # per-dir env vars
brew "duf"                 # disk usage (df alternative)
brew "dust"                # disk usage (du alternative)
brew "eza"                 # modern ls
brew "fd"                  # user-friendly find
brew "fzf"                 # fuzzy finder
brew "gh"                  # GitHub CLI
brew "git"                 # Git
brew "git-delta"           # syntax-aware diff pager (used by git/.gitconfig)
brew "gnu-sed"             # GNU sed
brew "htop"                # interactive process viewer
brew "httpie"              # HTTP client
brew "jq"                  # JSON processor
brew "lsd"                 # ls with icons
brew "ripgrep"             # fast grep
brew "starship"            # cross-shell prompt
brew "stow"                # dotfiles symlinks
brew "tailscale"           # Tailscale CLI (WireGuard mesh VPN)
brew "tldr"                # simplified man pages
brew "tree"                # directory tree
brew "wget"                # file retriever
brew "yq"                  # YAML/JSON/XML/CSV processor
brew "zoxide"              # smarter cd
brew "zsh"                 # Z shell (Homebrew build)
brew "zsh-autosuggestions"
brew "zsh-history-substring-search"  # arrow-key history search (sourced in .zshrc §16)
brew "zsh-syntax-highlighting"

# ---------- Languages & Runtimes ----------
brew "node"                # Node.js (current)
brew "nvm"                 # Node version manager
brew "openjdk"             # Java JDK (latest)
brew "openjdk@21"          # Java JDK 21 (LTS)
brew "gradle"              # JVM build tool
brew "pipx"                # isolated Python CLIs
brew "pyenv"               # Python version manager
brew "pyenv-virtualenv"    # pyenv virtualenv plugin
brew "python@3.11"         # Python 3.11
brew "python-gdbm@3.11"    # gdbm bindings for 3.11
brew "python-tk@3.11"      # Tk bindings for 3.11
brew "python@3.12"         # Python 3.12
brew "rbenv"               # Ruby version manager
brew "rbenv-default-gems"  # auto-install default gems
brew "rbenv-gemset"        # gemset support for rbenv

# ---------- Libraries & Build Deps ----------
brew "openssl@3"
brew "tcl-tk"
brew "zlib"

# ---------- Databases & Storage ----------
brew "duckdb"
brew "mysql"
brew "postgresql@16"
brew "redis"

# ---------- Containers & Infrastructure ----------
brew "colima"              # lightweight container runtime (Docker alternative)
brew "docker"              # Docker CLI
brew "podman"              # rootless container engine
brew "helm"                # Kubernetes package manager
brew "k9s"                 # Kubernetes TUI
brew "kubectx"             # kubectl context switcher
brew "kubernetes-cli"      # provides kubectl
brew "opentofu"            # open-source Terraform fork
brew "tflint"              # Terraform linter
brew "hashicorp/tap/terraform"

# ---------- GUI Apps ----------
cask "1password-cli"       # 1Password command-line
cask "bunch"               # workflow automation
cask "font-hack-nerd-font"
cask "ghostty"             # GPU-accelerated terminal
cask "iterm2"              # terminal emulator
cask "mysql-shell"         # MySQL Shell
cask "tailscale-app"       # Tailscale GUI
cask "visual-studio-code"

# ---------- VS Code Extensions ----------

# Editor, theming, motion
vscode "alexesprit.vscode-slack-dark-theme"
vscode "ms-vscode.atom-keybindings"
vscode "pkief.material-icon-theme"
vscode "stonebuddha.tomorrow-and-tomorrow-night-operator-mono-theme-tweaked"
vscode "unnamedstudio.spongetheme"
vscode "vscodevim.vim"
vscode "xyz.local-history"

# AI assistants
vscode "anthropic.claude-code"
vscode "buildwithlayer.mcp-integration-expert-eligr"
vscode "github.copilot"
vscode "github.copilot-chat"
vscode "google.geminicodeassist"
vscode "moonshot-ai.kimi-code"
vscode "openai.chatgpt"
vscode "visualstudioexptteam.intellicode-api-usage-examples"
vscode "visualstudioexptteam.vscodeintellicode"

# Git & GitHub / GitLab
vscode "eamodio.gitlens"
vscode "github.codespaces"
vscode "github.remotehub"
vscode "github.vscode-pull-request-github"
vscode "gitlab.gitlab-workflow"

# Python
vscode "ms-python.debugpy"
vscode "ms-python.isort"
vscode "ms-python.python"
vscode "ms-python.vscode-pylance"
vscode "ms-python.vscode-python-envs"

# Jupyter
vscode "ms-toolsai.jupyter"
vscode "ms-toolsai.jupyter-keymap"
vscode "ms-toolsai.jupyter-renderers"
vscode "ms-toolsai.vscode-jupyter-cell-tags"
vscode "ms-toolsai.vscode-jupyter-slideshow"

# Java / JVM
vscode "asf.apache-netbeans-java"
vscode "oracle-labs-graalvm.micronaut"
vscode "redhat.java"
vscode "vmware.vscode-boot-dev-pack"
vscode "vmware.vscode-spring-boot"
vscode "vscjava.vscode-gradle"
vscode "vscjava.vscode-java-debug"
vscode "vscjava.vscode-java-dependency"
vscode "vscjava.vscode-java-pack"
vscode "vscjava.vscode-java-test"
vscode "vscjava.vscode-maven"
vscode "vscjava.vscode-spring-boot-dashboard"
vscode "vscjava.vscode-spring-initializr"

# Other languages & build tooling
vscode "golang.go"
vscode "mathworks.language-matlab"
vscode "ms-dotnettools.vscode-dotnet-runtime"
vscode "ms-vscode.cmake-tools"
vscode "ms-vscode.cpp-devtools"
vscode "ms-vscode.cpptools"
vscode "ms-vscode.cpptools-extension-pack"
vscode "ms-vscode.cpptools-themes"
vscode "ms-vscode.makefile-tools"
vscode "ms-vscode.powershell"
vscode "msjsdiag.vscode-react-native"
vscode "shopify.ruby-lsp"
vscode "twxs.cmake"

# Node / JS / Web
vscode "chris-noring.node-snippets"
vscode "christian-kohler.npm-intellisense"
vscode "dbaeumer.vscode-eslint"
vscode "esbenp.prettier-vscode"
vscode "ms-playwright.playwright"
vscode "ritwickdey.liveserver"

# Database / SQL
vscode "bajdzis.vscode-database"
vscode "cweijan.dbclient-jdbc"
vscode "cweijan.vscode-database-client2"
vscode "formulahendry.vscode-mysql"
vscode "kx.kdb"
vscode "ms-mssql.data-workspace-vscode"
vscode "ms-mssql.mssql"
vscode "ms-mssql.sql-bindings-vscode"
vscode "ms-mssql.sql-database-projects-vscode"
vscode "mtxr.sqltools"
vscode "oracle.mysql-shell-for-vs-code"
vscode "randomfractalsinc.duckdb-sql-tools"

# Containers / Kubernetes / Vagrant
vscode "bbenoist.vagrant"
vscode "docker.docker"
vscode "formulahendry.docker-explorer"
vscode "ms-azuretools.vscode-containers"
vscode "ms-azuretools.vscode-docker"
vscode "ms-kubernetes-tools.vscode-kubernetes-tools"
vscode "ms-vscode-remote.remote-containers"

# Cloud (Azure / GCP / Oracle)
vscode "googlecloudtools.cloudcode"
vscode "joaofelipes.oci-policy-language"
vscode "linjun.oracle-support"
vscode "ms-azuretools.vscode-azureresourcegroups"
vscode "ms-azuretools.vscode-azureterraform"
vscode "ms-vscode.azure-repos"
vscode "oracle.apm"
vscode "oracle.faas"
vscode "oracle.oci-core"
vscode "oracle.oci-vscode-toolkit"
vscode "oracle.odsc"
vscode "oracle.oracle-jet-core"
vscode "oracle.rms"
vscode "oracle.sql-developer"

# Infrastructure as Code
vscode "hashicorp.terraform"
vscode "opentofu.vscode-opentofu"
vscode "run-at-scale.terraform-doc-snippets"

# Remote development
vscode "ms-vscode-remote.remote-ssh"
vscode "ms-vscode-remote.remote-ssh-edit"
vscode "ms-vscode.remote-explorer"
vscode "ms-vscode.remote-repositories"
vscode "ms-vscode.remote-server"

# Files & markup
vscode "davidanson.vscode-markdownlint"
vscode "mechatroner.rainbow-csv"
vscode "mindaro-dev.file-downloader"
vscode "redhat.vscode-xml"
vscode "redhat.vscode-yaml"
vscode "tomoki1207.pdf"
vscode "yzhang.markdown-all-in-one"

# Security / analysis
vscode "redhat.fabric8-analytics"
