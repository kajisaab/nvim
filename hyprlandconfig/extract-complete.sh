#!/bin/bash
# COMPLETE HyprFlux Configuration Extraction Script
# This version includes SDDM theme, brightness configs, and all Waybar layouts

set -e

CONFIG_DIR="$HOME/Documents/hyprlandconfig"
echo "=== Complete HyprFlux/Hyprland Configuration Extraction ==="
echo "Target directory: $CONFIG_DIR"
echo ""

# Create directory structure
echo "Creating directory structure..."
mkdir -p "$CONFIG_DIR"/{hypr,waybar,kitty,rofi,nvim,fonts,scripts,docs,sddm}

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
echo "Copying UserConfigs..."
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
echo "Copying UserScripts..."
cp ~/.config/hypr/UserScripts/WallpaperAutoChange.sh "$CONFIG_DIR/hypr/UserScripts/" 2>/dev/null
cp ~/.config/hypr/UserScripts/WallpaperRandom.sh "$CONFIG_DIR/hypr/UserScripts/" 2>/dev/null
cp ~/.config/hypr/UserScripts/WallpaperSelect.sh "$CONFIG_DIR/hypr/UserScripts/" 2>/dev/null

# Copy essential scripts from main scripts folder (INCLUDING BRIGHTNESS!)
echo "Copying essential scripts..."
cp ~/.config/hypr/scripts/RefreshNoWaybar.sh "$CONFIG_DIR/hypr/scripts/" 2>/dev/null || echo "Info: RefreshNoWaybar.sh not found"
cp ~/.config/hypr/scripts/Brightness.sh "$CONFIG_DIR/hypr/scripts/" 2>/dev/null || echo "Info: Brightness.sh not found"
cp ~/.config/hypr/scripts/BrightnessKbd.sh "$CONFIG_DIR/hypr/scripts/" 2>/dev/null || echo "Info: BrightnessKbd.sh not found"
cp ~/.config/hypr/scripts/Volume.sh "$CONFIG_DIR/hypr/scripts/" 2>/dev/null || echo "Info: Volume.sh not found"

# Extract Waybar configurations (ALL LAYOUTS)
echo "Extracting Waybar configurations..."
mkdir -p "$CONFIG_DIR/waybar"/{configs,style}

# Copy ALL waybar config files
cp ~/.config/waybar/Modules "$CONFIG_DIR/waybar/" 2>/dev/null
cp ~/.config/waybar/ModulesWorkspaces "$CONFIG_DIR/waybar/" 2>/dev/null
cp ~/.config/waybar/ModulesCustom "$CONFIG_DIR/waybar/" 2>/dev/null
cp ~/.config/waybar/ModulesGroups "$CONFIG_DIR/waybar/" 2>/dev/null
cp ~/.config/waybar/UserModules "$CONFIG_DIR/waybar/" 2>/dev/null || touch "$CONFIG_DIR/waybar/UserModules"

# Copy ALL available configs (including ones with brightness)
echo "Copying all Waybar layouts..."
cp -r ~/.config/waybar/configs/* "$CONFIG_DIR/waybar/configs/" 2>/dev/null

# Copy all styles
cp -r ~/.config/waybar/style/* "$CONFIG_DIR/waybar/style/" 2>/dev/null || true

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

# Extract SDDM theme and config (REQUIRES SUDO)
echo ""
echo "Extracting SDDM login theme (may require password)..."
if [ -f /etc/sddm.conf ]; then
    sudo cp /etc/sddm.conf "$CONFIG_DIR/sddm/sddm.conf" 2>/dev/null
    sudo chown $USER:$USER "$CONFIG_DIR/sddm/sddm.conf"
    echo "✓ SDDM config extracted"
else
    echo "⚠ SDDM config not found"
fi

if [ -d /usr/share/sddm/themes/simple-sddm-2 ]; then
    sudo cp -r /usr/share/sddm/themes/simple-sddm-2 "$CONFIG_DIR/sddm/" 2>/dev/null
    sudo chown -R $USER:$USER "$CONFIG_DIR/sddm/simple-sddm-2"
    echo "✓ SDDM theme 'simple-sddm-2' extracted"
else
    echo "⚠ SDDM theme 'simple-sddm-2' not found"
fi

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

# SDDM login manager
sudo pacman -S sddm qt5-virtualkeyboard qt5-graphicaleffects qt5-quickcontrols2 qt5-svg
```

## Additional Dependencies
```bash
# Clipboard manager
sudo pacman -S wl-clipboard cliphist

# Notification daemon
sudo pacman -S swaync

# Network applet
sudo pacman -S network-manager-applet

# Bluetooth
sudo pacman -S blueman

# File manager
sudo pacman -S thunar gvfs thunar-volman tumbler

# Fonts
sudo pacman -S ttf-jetbrains-mono-nerd nerd-fonts-complete

# Icon theme
sudo pacman -S papirus-icon-theme

# Color picker
sudo pacman -S hyprpicker

# System utilities
sudo pacman -S polkit-gnome brightnessctl playerctl pavucontrol pamixer

# Screenshot tool
sudo pacman -S grim slurp

# QoL tools
sudo pacman -S jq bc socat

# Image manipulation (for wallpaper effects)
sudo pacman -S imagemagick
```

## AUR Packages (install with yay or paru)
```bash
# Monitor configuration GUI
yay -S nwg-displays

# Quickshell (desktop overview alternative)
yay -S quickshell-git

# Additional tools
yay -S wallust  # Color scheme generator from wallpaper

# HyprFlux (if using the full suite)
# yay -S hyprflux-git
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

## Enable SDDM
```bash
sudo systemctl enable sddm
```
EOF

# Create feature availability doc
cat > "$CONFIG_DIR/docs/FEATURES.md" << 'EOF'
# Available Features in This Configuration

## Waybar Layouts

Your backup includes MULTIPLE Waybar layouts with different features:

### Layouts WITH Brightness Controls:
- `[TOP] Default Laptop Custom` ✅ (Recommended for laptops)
- `[TOP & BOT] SummitSplit` ✅
- `[TOP] Minimal.jsonc` ✅

### Layouts WITHOUT Brightness:
- `[TOP] Default Laptop` (your current active one)
- `[TOP] Default`
- `[TOP] Simple`
- `[TOP] Simpliest`

## Brightness Controls

Location: `hypr/scripts/Brightness.sh`

Features:
- Uses `brightnessctl` for backlight control
- Shows notifications with icons
- Adjusts in 10% steps
- Min: 5%, Max: 100%

## Display Settings

- GUI tool: `nwg-displays` (needs to be installed)
- Config file: `hypr/monitors.conf`
- Command: `hyprctl monitors` to list

## Login Screen (SDDM)

- Theme: `simple-sddm-2`
- Config: `sddm/sddm.conf`
- Theme files: `sddm/simple-sddm-2/`

## Switching Waybar Layouts

Method 1 - Keybinding:
```
SUPER + ALT + B
```

Method 2 - Script:
```bash
~/.config/hypr/scripts/WaybarLayout.sh
```

Method 3 - Manual:
```bash
ln -sf ~/.config/waybar/configs/[TOP]\ Default\ Laptop\ Custom ~/.config/waybar/config
pkill waybar && waybar &
```
EOF

echo ""
echo "=== Extraction Complete! ==="
echo "Configuration files saved to: $CONFIG_DIR"
echo ""
echo "✓ Hyprland configs"
echo "✓ Waybar configs (ALL layouts including brightness)"
echo "✓ Kitty config"
echo "✓ Rofi config"
echo "✓ Neovim config"
echo "✓ Brightness scripts"
echo "✓ SDDM login theme"
echo ""
echo "See docs/FEATURES.md for details on available features"
echo "See ADD-MISSING-FEATURES.md for how to activate brightness and display settings"
