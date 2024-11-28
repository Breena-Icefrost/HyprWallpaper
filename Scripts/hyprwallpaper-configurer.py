"""
Author  - Breena Icefrost
Date    - 2024-11-28
Version - 0.7
"""

import os, sys
from pathlib import Path

home = Path.home()

# Will try to know if the hyprpaper config already exists or not, if not, it will be created.
try:
    with open(home / ".config/hypr/hyprpaper.conf", "r") as f:
        lines = f.readlines()
    f.close()
    existingFile = True
except:
    f = open(home / ".config/hypr/hyprpaper.conf", "x")
    f.close()
    existingFile = False

# Removes the general wallpaper, leaving the previous or non-existing config behind.
def generalWallpaperRemover(display):
    with open(home / ".config/hypr/hyprpaper.conf", 'w') as file:
        for line in lines:
            if "ALL" in line:
                print("Found an imcompatible configuration, removing it...")
            else:
                file.write(line)
                print(line)

# Set of instructions to either not do anything because it's already working, or configure to make it work.
def importScreen(display):
    existingConfig = False
    # If file exists, check if it's already well configured.
    if existingFile == True:
        for line in lines:
            if display in line:
                existingConfig = True
    # Delete general wallpapers in case it's not going to be used.
    if display != "ALL":
        generalWallpaperRemover(display)
    # If not configured, add the display. 
    if existingConfig == False:
        if display == "ALL":
            with open(home / ".config/hypr/hyprpaper.conf", "a") as file:
                file.write(f"preload = {home}/.config/hypr/utilities/{display}-wallpaper.png\n")
                file.write(f"wallpaper = , {home}/.config/hypr/utilities/{display}-wallpaper.png\n")
                file.close()
        else:
            with open(home / ".config/hypr/hyprpaper.conf", "a") as file:
                file.write(f"preload = {home}/.config/hypr/utilities/{display}-wallpaper.png\n")
                file.write(f"wallpaper = {display}, {home}/.config/hypr/utilities/{display}-wallpaper.png\n")
                file.close()

if __name__ == "__main__":
    importScreen(sys.argv[1])
