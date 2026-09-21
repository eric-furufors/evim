#!/usr/bin/env bash
set -euo pipefail

sudo apt update
sudo apt install -y ninja-build gettext cmake unzip curl build-essential git ripgrep nodejs npm

# Neovim (stable release)
if [ -d "$HOME/neovim" ]; then
  git -C "$HOME/neovim" fetch --all --tags --force
else
  git clone https://github.com/neovim/neovim.git "$HOME/neovim"
fi

cd "$HOME/neovim"
git checkout stable
make distclean
make CMAKE_BUILD_TYPE=Release
sudo rm -rf /usr/local/share/nvim
sudo make install

# lazy.nvim
if [ ! -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]; then
  git clone --depth 1 https://github.com/folke/lazy.nvim.git \
    "$HOME/.local/share/nvim/lazy/lazy.nvim"
fi
