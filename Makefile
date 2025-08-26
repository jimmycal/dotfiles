.PHONY: bootstrap stow unstow update

bootstrap:
\t./bootstrap.sh

stow:
\tstow -v zsh brew -t $(HOME)

unstow:
\tstow -Dv zsh brew -t $(HOME)

update:
\tgit pull --rebase && brew update && brew upgrade
