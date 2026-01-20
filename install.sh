#!/bin/bash

# Script only for use with DevPod, chezmoi will handle dotfiles on host

if ! command -v chezmoi &> /dev/null; then
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b=$HOME/.local/bin
  export PATH="$HOME/.local/bin:$PATH"
fi

chezmoi apply --force
