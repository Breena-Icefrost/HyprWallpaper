#!/bin/bash

# TO TEST!!

mkdir ~/.config/hyprconfig/
mkdir ~/.config/hyprconfig/hyprwallpaper/

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

cd "$parent_path"

cp Scripts/* ~/.config/hyprconfig/hyprwallpaper/

global_path=$(cd ~/ ; pwd -P)

echo "alias hyprwallpaper='bash ""$global_path""/.config/hyprconfig/hyprwallpaper/hyprwallpaper.sh'" >> $global_path'/.bashrc'
source $global_path'/.bashrc'