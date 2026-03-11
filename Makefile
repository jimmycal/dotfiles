.PHONY: bootstrap stow unstow update sync

bootstrap:
	./bootstrap.sh

stow:
	stow -v zsh brew git starship -t $(HOME)

unstow:
	stow -Dv zsh brew git starship -t $(HOME)

update:
	git pull --rebase && brew update && brew upgrade && brew bundle --file brew/.Brewfile

sync:
	git add -A && git commit -m "chore: sync dotfiles" && git push
