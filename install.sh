#!/bin/bash

# Script only for use with DevPod, chezmoi will handle dotfiles on host

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

if ! command -v chezmoi &> /dev/null; then
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$BIN_DIR"
fi

"$BIN_DIR/chezmoi" apply --force --tty=false
