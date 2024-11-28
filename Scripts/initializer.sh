#!/bin/bash

# Trap CTRL+C (SIGINT) and handle it
trap "echo 'Closing HyprWallpaper...'; exit 0" SIGINT

echo Starting HyprWallpaper...

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

source hyprwallpaper.sh

folderDetector
reformater
wallpaperSelector