#!/usr/bin/bash

# Trap CTRL+C (SIGINT) and handle it
trap "echo 'Closing HyprWallpaper...'; exit 0" SIGINT

echo Starting HyprWallpaper...

if [[ -d ~/Wallpapers ]]; then
        echo Existing wallpaper folder.
else
        echo No existing wallpaper folder, creating...
        mkdir -p ~/Wallpapers &&
        wget -O ~/Wallpapers/default-wallpaper.jpg https://wallpapercave.com/wp/wp2342429.jpg -q &&
        sleep 0
fi

find ~/Wallpapers/ -name "*.jpg" -exec mogrify -format png {} \; &&
find ~/Wallpapers/ -name "*.jpg" -exec rm {} \; &&

find ~/Wallpapers/ -name "*.jpeg" -exec mogrify -format png {} \; &&
find ~/Wallpapers/ -name "*.jpeg" -exec rm {} \; &&

if [[ -d ~/.config/hypr/utilities ]]; then
        echo Existing utilities folder.
else
        echo No existing utilities folder, creating...
        mkdir -p ~/.config/hypr/utilities/oldWallpapers &&
        if [[ -f ~/Wallpapers/default-wallpaper.png ]]; then
                cp ~/Wallpapers/default-wallpaper.png ~/.config/hypr/utilities/ALL-wallpaper.png
                hyprctl hyprpaper unload all >/dev/null 2>&1 &&
                hyprctl hyprpaper preload ~/.config/hypr/utilities-ALL-wallpaper.png >/dev/null 2>&1 &&
                hyprctl hyprpaper wallpaper "*,~/.config/hypr/utilities/ALL-wallpaper.png" >/dev/null 2>&1
        fi
fi

ENTRY=$(ls ~/Wallpapers/ | smenu -t -W $'\n' -m '      Select the wallpaper you wish to use;')

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

cd "$parent_path"

if [[ -f ~/Wallpapers/$ENTRY ]]; then
        DISPLAY=$(python hyprwallpaper-displays.py | smenu -t -m '  Select the display;')
        if [[ -f ~/.config/hypr/utilities/"$DISPLAY"-wallpaper.png ]]; then
                mv ~/.config/hypr/utilities/"$DISPLAY"-wallpaper.png ~/.config/hypr/utilities/oldWallpapers/"$DISPLAY"-oldWallpaper.png
        fi
        cp ~/Wallpapers/"$ENTRY" ~/.config/hypr/utilities/"$DISPLAY"-wallpaper.png &&
        hyprctl hyprpaper unload all >/dev/null 2>&1 &&
        if [[ $DISPLAY = "ALL" ]]; then
                echo "Changing all displays' wallpapers!"
                for monitor in $(hyprctl monitors | grep 'Monitor' | awk '{ print $2 }'); do
                        hyprctl hyprpaper preload ~/.config/hypr/utilities/"$DISPLAY"-wallpaper.png >/dev/null 2>&1 &&
                        hyprctl hyprpaper wallpaper "$monitor"", ~/.config/hypr/utilities/"$DISPLAY"-wallpaper.png" >/dev/null 2>&1
                done
        else
                echo "Changing $DISPLAY's wallpaper!"
                hyprctl hyprpaper preload ~/.config/hypr/utilities/"$DISPLAY"-wallpaper.png >/dev/null 2>&1 &&
                hyprctl hyprpaper wallpaper "$DISPLAY,~/.config/hypr/utilities/"$DISPLAY"-wallpaper.png" >/dev/null 2>&1
        fi
        python hyprwallpaper-configurer.py $DISPLAY
else
        echo $ENTRY
        echo 'Invalid selection. Exiting...'
fi
