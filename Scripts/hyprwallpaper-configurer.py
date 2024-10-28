"""
Author  - Breena Icefrost
Date    - 2024-10-04
Version - 0.6
"""

import os, sys
from pathlib import Path

home = Path.home()

existingFile = True

try:
    with open(home / ".config/hypr/hyprpaper.conf", "r") as f:
        lines = f.readlines()
    f.close()
except:
    f = open(home / ".config/hypr/hyprpaper.conf", "x")
    f.close()
    existingFile = False

def importScreen(display):
    existingConfig = False
    if existingFile == True:
        for line in lines:
            if display in line:
                existingConfig = True
    if existingConfig == False:
        if display == "ALL":
            with open(home / ".config/hypr/hyprpaper.conf", "w") as file:
                file.write(f"preload = {home}/.config/hypr/utilities/{display}-wallpaper.png\n")
                file.write(f"wallpaper = , {home}/.config/hypr/utilities/{display}-wallpaper.png\n")
                file.close()
        else:
            with open(home / ".config/hypr/hyprpaper.conf", 'w') as file:
                for line in lines:
                    if "ALL" in line:
                        print("Found an imcompatible configuration, removing it...")
                    else:
                        file.write(line)
            with open(home / ".config/hypr/hyprpaper.conf", "a") as file:
                file.write(f"preload = {home}/.config/hypr/utilities/{display}-wallpaper.png\n")
                file.write(f"wallpaper = {display}, {home}/.config/hypr/utilities/{display}-wallpaper.png\n")
                file.close()

if __name__ == "__main__":
    importScreen(sys.argv[1])
