#!/usr/bin/env bash

# install useful packages for development
set -euo pipefail

sudo apt-get update
sudo apt-get install -y \
    exa \
    fd-find \
    fzf \
    ripgrep \
    htop \
    neofetch \
    tree

# link fd to fdfind for compatibility with tools that expect 'fd'
ln -s $(which fdfind) ~/.local/bin/fd

# install via uv
uv tool install tldr \
    && tldr --update

# install via script
# cd ==> zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
# add `eval "$(zoxide init zsh)"` to .zshrc (done in post-create-dotfiles.sh) to initialize zoxide
echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc

