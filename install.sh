#!/bin/bash

# Script only for use with DevPod, chezmoi will handle dotfiles on host

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

if ! command -v chezmoi &> /dev/null; then
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$BIN_DIR"
fi

if ! command -v starship &> /dev/null; then
    curl -sS https://starship.rs/install.sh | sh -s -- --yes -b "$BIN_DIR"
fi

"$BIN_DIR/chezmoi" apply --force --no-tty

GHOSTTY_SOURCE="$HOME/.terminfo/x/xterm-ghostty"

if [ -f "$GHOSTTY_SOURCE" ]; then
  tic -x "$GHOSTTY_SOURCE"
else
  echo "Ghostty terminfo source not found at $GHOSTTY_SOURCE"
fi

