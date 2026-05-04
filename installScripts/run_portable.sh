#!/usr/bin/env bash
export XDG_CONFIG_HOME="/home/eric/nvim/evim/portable/config"
export XDG_DATA_HOME="/home/eric/nvim/evim/portable/data"
export XDG_CACHE_HOME="/home/eric/nvim/evim/portable/cache"

# Run the AppImage if it exists, otherwise system nvim
if [ -f "/home/eric/nvim/evim/nvim.appimage" ]; then
    "/home/eric/nvim/evim/nvim.appimage" "$@"
else
    nvim "$@"
fi
