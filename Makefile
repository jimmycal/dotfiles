.PHONY: bootstrap stow unstow restow update sync brewfile-dump brewfile-check brewfile-drift

PACKAGES := zsh brew git starship claude
BREWFILE := $(CURDIR)/brew/.Brewfile

# Run the full fresh-Mac setup
bootstrap:
	./bootstrap.sh

# Symlink dotfiles into $(HOME) using GNU stow
stow:
	stow -v --target=$(HOME) $(PACKAGES)

# Remove the symlinks created by `stow`
unstow:
	stow -Dv --target=$(HOME) $(PACKAGES)

# Re-stow (idempotent — safe after adding/renaming files)
restow:
	stow -v --target=$(HOME) --restow $(PACKAGES)

# Pull latest changes and upgrade everything
update:
	git pull --rebase && brew update && brew upgrade && brew bundle --file=$(BREWFILE)

# Quick commit-and-push of the dotfiles repo (use sparingly; prefer real commit messages)
sync:
	git add -A && git commit -m "chore: sync dotfiles" && git push

# Snapshot the current machine state to a temp Brewfile (for diffing)
brewfile-dump:
	brew bundle dump --describe --force --file=/tmp/Brewfile.actual
	@echo "Wrote /tmp/Brewfile.actual"

# Verify the committed Brewfile matches what's installed
brewfile-check:
	brew bundle check --verbose --file=$(BREWFILE)

# Show drift between the committed Brewfile and the live machine
brewfile-drift: brewfile-dump
	@echo "--- committed                                +++ machine"
	@diff -u $(BREWFILE) /tmp/Brewfile.actual || true
