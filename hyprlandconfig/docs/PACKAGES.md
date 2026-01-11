# Required Packages for HyprFlux/Hyprland Setup

## Core Packages
```bash
# Hyprland and core components
sudo pacman -S hyprland hyprpaper hyprlock hypridle xdg-desktop-portal-hyprland

# Waybar (status bar)
sudo pacman -S waybar

# Terminal
sudo pacman -S kitty foot

# Application launcher
sudo pacman -S rofi-wayland

# Wallpaper daemon
sudo pacman -S swww

# Neovim and LazyVim
sudo pacman -S neovim git
```

## Additional Dependencies
```bash
# Clipboard manager
sudo pacman -S wl-clipboard cliphist

# Notification daemon
sudo pacman -S swaync

# Network applet
sudo pacman -S network-manager-applet

# File manager
sudo pacman -S thunar

# Fonts
sudo pacman -S ttf-jetbrains-mono-nerd nerd-fonts-complete

# Icon theme
sudo pacman -S papirus-icon-theme

# Color picker
sudo pacman -S hyprpicker

# System utilities
sudo pacman -S polkit-gnome brightnessctl playerctl pavucontrol

# Screenshot tool
sudo pacman -S grim slurp

# QoL tools
sudo pacman -S jq bc socat

# Image manipulation (for wallpaper effects)
sudo pacman -S imagemagick
```

## AUR Packages (install with yay or paru)
```bash
# HyprFlux (if using the full suite)
yay -S hyprflux-git

# Quickshell (desktop overview alternative)
yay -S quickshell-git

# Additional tools
yay -S wallust  # Color scheme generator from wallpaper
yay -S nwg-displays  # GUI for monitor configuration
```

## Optional Packages
```bash
# Browser
sudo pacman -S firefox

# File manager alternatives
sudo pacman -S dolphin

# Additional terminals
sudo pacman -S alacritty
```
