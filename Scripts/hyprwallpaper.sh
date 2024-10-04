#!/usr/bin/bash

# Trap CTRL+C (SIGINT) and handle it
trap "echo 'Closing HyprWallpaper...'; exit 0" SIGINT

echo Starting HyprWallpaper...

if [[ -d ~/Pictures/Wallpapers ]]; then
        echo Existing wallpaper folder.
else
        echo No existing wallpaper folder, creating...
        mkdir ~/Pictures/Wallpapers &&
        wget -O ~/Pictures/Wallpapers/default-wallpaper.jpg https://wallpapercave.com/wp/wp2342429.jpg -q &&
        sleep 0
fi

find ~/Pictures/Wallpapers/ -name "*.jpg" -exec mogrify -format png {} \; &&
find ~/Pictures/Wallpapers/ -name "*.jpg" -exec rm {} \; &&

if [[ -d ~/.config/hypr/utilities ]]; then
        echo Existing utilities folder.
else
        echo No existing utilities folder, creating...
        mkdir ~/.config/hypr/utilities &&
        mkdir ~/.config/hypr/utilities/oldWallpapers &&
        if [[ -f ~/Pictures/Wallpapers/default-wallpaper.png ]]; then
                cp ~/Pictures/Wallpapers/default-wallpaper.png
        fi
fi

ENTRY=$(ls ~/Pictures/Wallpapers/ | smenu -t -W $'\n' -m '      Select the wallpaper you wish to use;')

if [[ -f ~/Pictures/Wallpapers/$ENTRY ]]; then
        DISPLAY=$(python ~/.config/hypr/scripts/HyprWallpaper/hyprwallpaper-displays.py | smenu -t -m '  Select the display;')
        if [[ -f ~/.config/hypr/utilities/"$DISPLAY"-wallpaper.png ]]; then
                mv ~/.config/hypr/utilities/"$DISPLAY"-wallpaper.png ~/.config/hypr/utilities/oldWallpapers/"$DISPLAY"-oldWallpaper.png
        fi
        cp ~/Pictures/Wallpapers/"$ENTRY" ~/.config/hypr/utilities/"$DISPLAY"-wallpaper.png &&
        hyprctl hyprpaper unload all >/dev/null 2>&1 &&
        hyprctl hyprpaper preload ~/.config/hypr/utilities/"$DISPLAY"-wallpaper.png >/dev/null 2>&1 &&
        hyprctl hyprpaper wallpaper "$DISPLAY,~/.config/hypr/utilities/"$DISPLAY"-wallpaper.png" >/dev/null 2>&1
        python ~/.config/hypr/scripts/HyprWallpaper/hyprwallpaper-configurer.py $DISPLAY
else
        echo $ENTRY
        echo 'Invalid selection. Exiting...'
fi
