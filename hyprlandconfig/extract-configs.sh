#!/bin/bash
# HyprFlux Configuration Extraction Script
# This script copies all relevant configurations to the hyprlandconfig folder

set -e

CONFIG_DIR="$HOME/Documents/hyprlandconfig"
echo "=== Extracting HyprFlux/Hyprland Configurations ==="
echo "Target directory: $CONFIG_DIR"

# Create directory structure
echo "Creating directory structure..."
mkdir -p "$CONFIG_DIR"/{hypr,waybar,kitty,rofi,nvim,fonts,scripts,docs}

# Extract Hyprland configurations
echo "Extracting Hyprland configurations..."
mkdir -p "$CONFIG_DIR/hypr"/{UserConfigs,UserScripts,scripts}

# Copy main Hyprland configs
cp ~/.config/hypr/hyprland.conf "$CONFIG_DIR/hypr/" 2>/dev/null || echo "Warning: hyprland.conf not found"
cp ~/.config/hypr/monitors.conf "$CONFIG_DIR/hypr/" 2>/dev/null || echo "Warning: monitors.conf not found"
cp ~/.config/hypr/workspaces.conf "$CONFIG_DIR/hypr/" 2>/dev/null || echo "Warning: workspaces.conf not found"
cp ~/.config/hypr/hypridle.conf "$CONFIG_DIR/hypr/" 2>/dev/null || echo "Warning: hypridle.conf not found"
cp ~/.config/hypr/hyprlock.conf "$CONFIG_DIR/hypr/" 2>/dev/null || echo "Warning: hyprlock.conf not found"

# Copy UserConfigs (keybindings, startup apps, etc.)
cp ~/.config/hypr/UserConfigs/UserKeybinds.conf "$CONFIG_DIR/hypr/UserConfigs/" 2>/dev/null
cp ~/.config/hypr/UserConfigs/Startup_Apps.conf "$CONFIG_DIR/hypr/UserConfigs/" 2>/dev/null
cp ~/.config/hypr/UserConfigs/01-UserDefaults.conf "$CONFIG_DIR/hypr/UserConfigs/" 2>/dev/null
cp ~/.config/hypr/UserConfigs/ENVariables.conf "$CONFIG_DIR/hypr/UserConfigs/" 2>/dev/null
cp ~/.config/hypr/UserConfigs/UserSettings.conf "$CONFIG_DIR/hypr/UserConfigs/" 2>/dev/null
cp ~/.config/hypr/UserConfigs/UserDecorations.conf "$CONFIG_DIR/hypr/UserConfigs/" 2>/dev/null
cp ~/.config/hypr/UserConfigs/UserAnimations.conf "$CONFIG_DIR/hypr/UserConfigs/" 2>/dev/null
cp ~/.config/hypr/UserConfigs/WindowRules.conf "$CONFIG_DIR/hypr/UserConfigs/" 2>/dev/null
cp ~/.config/hypr/UserConfigs/Laptops.conf "$CONFIG_DIR/hypr/UserConfigs/" 2>/dev/null
cp ~/.config/hypr/UserConfigs/LaptopDisplay.conf "$CONFIG_DIR/hypr/UserConfigs/" 2>/dev/null

# Copy UserScripts (wallpaper automation, etc.)
cp ~/.config/hypr/UserScripts/WallpaperAutoChange.sh "$CONFIG_DIR/hypr/UserScripts/" 2>/dev/null
cp ~/.config/hypr/UserScripts/WallpaperRandom.sh "$CONFIG_DIR/hypr/UserScripts/" 2>/dev/null
cp ~/.config/hypr/UserScripts/WallpaperSelect.sh "$CONFIG_DIR/hypr/UserScripts/" 2>/dev/null

# Copy essential scripts from main scripts folder
cp ~/.config/hypr/scripts/RefreshNoWaybar.sh "$CONFIG_DIR/hypr/scripts/" 2>/dev/null || echo "Info: RefreshNoWaybar.sh not found"

# Extract Waybar configurations
echo "Extracting Waybar configurations..."
mkdir -p "$CONFIG_DIR/waybar"/{configs,style}

# Copy waybar files
cp ~/.config/waybar/Modules "$CONFIG_DIR/waybar/" 2>/dev/null
cp ~/.config/waybar/ModulesWorkspaces "$CONFIG_DIR/waybar/" 2>/dev/null
cp ~/.config/waybar/ModulesCustom "$CONFIG_DIR/waybar/" 2>/dev/null
cp ~/.config/waybar/ModulesGroups "$CONFIG_DIR/waybar/" 2>/dev/null
cp ~/.config/waybar/UserModules "$CONFIG_DIR/waybar/" 2>/dev/null || touch "$CONFIG_DIR/waybar/UserModules"

# Copy the active config (follow symlink)
if [ -L ~/.config/waybar/config ]; then
    cp -L ~/.config/waybar/config "$CONFIG_DIR/waybar/configs/default-config" 2>/dev/null
else
    cp ~/.config/waybar/config "$CONFIG_DIR/waybar/configs/default-config" 2>/dev/null || echo "Info: waybar config not found"
fi

# Copy the active style (follow symlink)
if [ -L ~/.config/waybar/style.css ]; then
    cp -L ~/.config/waybar/style.css "$CONFIG_DIR/waybar/style/default-style.css" 2>/dev/null
else
    cp ~/.config/waybar/style.css "$CONFIG_DIR/waybar/style/default-style.css" 2>/dev/null || echo "Info: waybar style.css not found"
fi

# Extract Kitty configuration
echo "Extracting Kitty configuration..."
cp ~/.config/kitty/kitty.conf "$CONFIG_DIR/kitty/" 2>/dev/null

# Extract Rofi configuration
echo "Extracting Rofi configuration..."
cp ~/.config/rofi/config.rasi "$CONFIG_DIR/rofi/" 2>/dev/null
cp ~/.config/rofi/master-config.rasi "$CONFIG_DIR/rofi/" 2>/dev/null
cp ~/.config/rofi/0-shared-fonts.rasi "$CONFIG_DIR/rofi/" 2>/dev/null
# Copy some theme configs
cp ~/.config/rofi/config-compact.rasi "$CONFIG_DIR/rofi/" 2>/dev/null || echo "Info: rofi theme files not found"

# Extract Neovim/LazyVim configuration
echo "Extracting Neovim/LazyVim configuration..."
cp -r ~/.config/nvim/* "$CONFIG_DIR/nvim/" 2>/dev/null || echo "Warning: nvim config not found"

# Document installed fonts
echo "Documenting installed fonts..."
cat > "$CONFIG_DIR/fonts/FONTS.md" << 'EOF'
# Required Fonts

## JetBrains Mono Nerd Font
This is the primary font used in Kitty terminal and system-wide.

Install via:
```bash
yay -S ttf-jetbrains-mono-nerd
# OR
sudo pacman -S ttf-jetbrains-mono-nerd
```

## Additional Nerd Fonts
For icons in waybar and rofi:
```bash
yay -S nerd-fonts-complete
# OR install specific ones:
sudo pacman -S ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono
```

## Verify Installation
```bash
fc-list | grep -i "JetBrains"
```
EOF

# Create package list
echo "Creating package dependency list..."
cat > "$CONFIG_DIR/docs/PACKAGES.md" << 'EOF'
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
EOF

echo ""
echo "=== Extraction Complete! ==="
echo "Configuration files saved to: $CONFIG_DIR"
echo ""
echo "Next steps:"
echo "1. Review the configs in $CONFIG_DIR"
echo "2. Read $CONFIG_DIR/docs/PACKAGES.md for dependencies"
echo "3. Use the setup guide in $CONFIG_DIR/docs/SETUP-GUIDE.md"
