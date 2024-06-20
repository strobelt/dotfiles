usermodmap=$HOME/.Xmodmap

if [ -f "$usermodmap" ]; then
    /usr/bin/xmodmap "$usermodmap"
fi

feh --randomize --bg-fill wallpapers/minimal-landscapes

picom -b &
