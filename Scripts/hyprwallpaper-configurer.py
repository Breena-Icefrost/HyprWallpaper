"""
Author  - Breena Lockser
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
except:
    f = open(home / ".config/hypr/hyprpaper.conf", "x")
    existingFile = False

def importScreen(display):
    existingConfig = False
    if existingFile == True:
        for line in lines:
            if display in line:
                existingConfig = True
    if existingConfig == False:
        with open(home / ".config/hypr/hyprpaper.conf", "a") as f:
            f.write(f"preload = {home}/.config/hypr/utilities/{display}-wallpaper.png\n")
            f.write(f"wallpaper = {display}.{home}/.config/hypr/utilities/{display}-wallpaper.png\n")
            f.close()

if __name__ == "__main__":
    importScreen(sys.argv[1])
