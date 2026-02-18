#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
DOTFILES_REPO="https://github.com/5fx7fvwbxh-lang/dotfiles"
WORKSPACE_DIR="/workspaces/my-site"

if [ ! -d "$DOTFILES_DIR" ]; then
	git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

pushd "$DOTFILES_DIR" >/dev/null
if [ -x "./install" ]; then
	./install
else
	bash ./install
fi
popd >/dev/null

cd "$WORKSPACE_DIR"

if [ -f "$HOME/.zshrc" ]; then
	zsh -lc "source $HOME/.zshrc"
fi
