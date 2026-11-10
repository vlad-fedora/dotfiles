#!/usr/bin/env bash
cd "$HOME/dotfiles" || exit 1
mkdir -p nixos config home

# NixOS
sudo cp /etc/nixos/*.nix nixos/
sudo chown -R "$USER": nixos

# Configuri din ~/.config
for d in hypr waybar rofi kitty swaync swayosd gtk-3.0 gtk-4.0; do
  if [ -d "$HOME/.config/$d" ]; then
    rm -rf "config/$d"
    cp -r "$HOME/.config/$d" config/
  fi
done
for f in starship.toml kdeglobals; do
  [ -f "$HOME/.config/$f" ] && cp "$HOME/.config/$f" config/
done

# Alte fișiere
[ -f "$HOME/.bashrc" ] && cp "$HOME/.bashrc" home/
[ -d "$HOME/.icons" ] && rm -rf home/icons && cp -r "$HOME/.icons" home/icons

# Wallpaper-uri (decomentează dacă nu sunt mari)
 [ -d "$HOME/Pictures/wallpapers" ] && rm -rf wallpapers && cp -r "$HOME/Pictures/wallpapers" wallpapers

git add -A
git commit -m "backup $(date +%F_%H:%M)" || echo "Nimic nou de salvat"
git push
