#!/bin/bash
# HyprFlux Configuration Deployment Script
# Run this script on a fresh Arch Linux installation after installing all required packages

set -e

CONFIG_SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== HyprFlux Configuration Deployment ==="
echo "Source: $CONFIG_SOURCE"
echo ""

# Function to backup existing config
backup_config() {
    local config_path="$1"
    if [ -e "$config_path" ]; then
        echo "Backing up existing config: $config_path"
        mv "$config_path" "${config_path}.backup-$(date +%Y%m%d-%H%M%S)"
    fi
}

# Check if required packages are installed
echo "Checking for required packages..."
REQUIRED_PACKAGES=(hyprland waybar kitty rofi-wayland swww neovim)
MISSING_PACKAGES=()

for package in "${REQUIRED_PACKAGES[@]}"; do
    if ! command -v "$package" &> /dev/null && ! pacman -Qi "$package" &> /dev/null 2>&1; then
        MISSING_PACKAGES+=("$package")
    fi
done

if [ ${#MISSING_PACKAGES[@]} -gt 0 ]; then
    echo "Warning: The following required packages are not installed:"
    printf '  - %s\n' "${MISSING_PACKAGES[@]}"
    echo ""
    read -p "Do you want to continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Deployment cancelled. Please install required packages first."
        echo "See docs/PACKAGES.md for the complete list."
        exit 1
    fi
fi

echo ""
echo "Step 1: Creating backup of existing configurations..."
backup_config "$HOME/.config/hypr"
backup_config "$HOME/.config/waybar"
backup_config "$HOME/.config/kitty"
backup_config "$HOME/.config/rofi"
backup_config "$HOME/.config/nvim"

echo ""
echo "Step 2: Deploying Hyprland configuration..."
mkdir -p "$HOME/.config/hypr"
cp -r "$CONFIG_SOURCE/hypr/"* "$HOME/.config/hypr/" 2>/dev/null || echo "Warning: Some Hyprland files not found"

echo ""
echo "Step 3: Deploying Waybar configuration..."
mkdir -p "$HOME/.config/waybar"/{configs,style}
cp -r "$CONFIG_SOURCE/waybar/"* "$HOME/.config/waybar/" 2>/dev/null || echo "Warning: Some Waybar files not found"

# Create symlinks for waybar
if [ -f "$HOME/.config/waybar/configs/default-config" ]; then
    ln -sf "$HOME/.config/waybar/configs/default-config" "$HOME/.config/waybar/config"
    echo "Created waybar config symlink"
fi

if [ -f "$HOME/.config/waybar/style/default-style.css" ]; then
    ln -sf "$HOME/.config/waybar/style/default-style.css" "$HOME/.config/waybar/style.css"
    echo "Created waybar style symlink"
fi

echo ""
echo "Step 4: Deploying Kitty configuration..."
mkdir -p "$HOME/.config/kitty"
cp "$CONFIG_SOURCE/kitty/kitty.conf" "$HOME/.config/kitty/" 2>/dev/null || echo "Warning: Kitty config not found"

echo ""
echo "Step 5: Deploying Rofi configuration..."
mkdir -p "$HOME/.config/rofi"
cp -r "$CONFIG_SOURCE/rofi/"* "$HOME/.config/rofi/" 2>/dev/null || echo "Warning: Some Rofi files not found"

echo ""
echo "Step 6: Deploying Neovim/LazyVim configuration..."
mkdir -p "$HOME/.config/nvim"
cp -r "$CONFIG_SOURCE/nvim/"* "$HOME/.config/nvim/" 2>/dev/null || echo "Warning: Some Neovim files not found"

echo ""
echo "Step 7: Making scripts executable..."
chmod +x "$HOME/.config/hypr/UserScripts/"*.sh 2>/dev/null || echo "Info: No UserScripts found"
chmod +x "$HOME/.config/hypr/scripts/"*.sh 2>/dev/null || echo "Info: No scripts found"

echo ""
echo "Step 8: Creating wallpaper directory..."
mkdir -p "$HOME/Pictures/wallpapers"
echo "Created: $HOME/Pictures/wallpapers"
echo "Please copy your wallpapers to this directory"

echo ""
echo "Step 9: Setting up permissions..."
chmod 644 "$HOME/.config/hypr/hyprland.conf" 2>/dev/null || true
chmod 644 "$HOME/.config/waybar/config" 2>/dev/null || true
chmod 644 "$HOME/.config/kitty/kitty.conf" 2>/dev/null || true

echo ""
echo "=== Deployment Complete! ==="
echo ""
echo "Next steps:"
echo "1. Copy your wallpapers to ~/Pictures/wallpapers/"
echo "2. Review and adjust monitor configuration in ~/.config/hypr/monitors.conf"
echo "3. Update default apps in ~/.config/hypr/UserConfigs/01-UserDefaults.conf"
echo "4. Start Hyprland with: Hyprland"
echo ""
echo "Optional:"
echo "- Enable wallpaper auto-change by uncommenting line in ~/.config/hypr/UserConfigs/Startup_Apps.conf"
echo "- Customize keybindings in ~/.config/hypr/UserConfigs/UserKeybinds.conf"
echo ""
echo "For troubleshooting, see: $CONFIG_SOURCE/docs/SETUP-GUIDE.md"
