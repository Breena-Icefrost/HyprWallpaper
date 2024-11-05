#!/bin/bash

# TO TEST!!

mkdir -p ~/.config/hyprconfig/hyprwallpaper/

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

cd "$parent_path"

cp Scripts/* ~/.config/hyprconfig/hyprwallpaper/

# TEMPORAL!! SHOULD BE CREATED AS A PACKAGE WHEN IT'S READY ENOUGH

global_path=$(cd ~/ ; pwd -P)

echo "alias hyprwallpaper='bash ""$global_path""/.config/hyprconfig/hyprwallpaper/hyprwallpaper.sh'" >> $global_path'/.bashrc'
source $global_path'/.bashrc'
