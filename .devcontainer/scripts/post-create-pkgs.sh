#!/usr/bin/env bash

# install useful packages for development
set -euo pipefail

sudo apt-get update
sudo apt-get install -y \
    exa \
    fdclone \
    fzf \
    ripgrep \
    htop \
    neofetch \
    tldr \
    tree

# install via script
# cd ==> zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

