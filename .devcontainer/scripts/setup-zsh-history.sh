#!/usr/bin/env bash

# Configure zsh to use persisted history from mounted volume
# History configuration is also set in dotfiles/zsh/settings.zsh for completeness
# Symlink setup here ensures history is persisted across container rebuilds
set -euo pipefail

HISTORY_DIR="/commandhistory"
HISTORY_FILE="$HISTORY_DIR/.zsh_history"
HOME_HISTORY="$HOME/.zsh_history"

# Create the directory if it doesn't exist
mkdir -p "$HISTORY_DIR"

# Set ownership to the current user
sudo chown -R "$(whoami)" "$HISTORY_DIR"

# If persisted history doesn't exist yet, copy from home if available
if [ ! -f "$HISTORY_FILE" ] && [ -f "$HOME_HISTORY" ] && [ ! -L "$HOME_HISTORY" ]; then
    echo "Initializing persisted history from existing home history..."
    cp "$HOME_HISTORY" "$HISTORY_FILE"
fi

# Ensure the history file exists on the volume
touch "$HISTORY_FILE"

# Remove any existing .zsh_history in home (file or broken symlink)
rm -f "$HOME_HISTORY"

# Create symlink from home directory to persisted volume
ln -sf "$HISTORY_FILE" "$HOME_HISTORY"

echo "Zsh history symlinked: $HOME_HISTORY -> $HISTORY_FILE"
echo "History will persist across container rebuilds"
