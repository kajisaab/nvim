# HyprFlux/Hyprland Setup Guide
Complete guide to recreate your Hyprland configuration on a fresh Arch Linux installation.

---

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Install Required Packages](#install-required-packages)
3. [Install Fonts](#install-fonts)
4. [Deploy Configurations](#deploy-configurations)
5. [Configure Individual Components](#configure-individual-components)
6. [Enable Wallpaper Automation](#enable-wallpaper-automation)
7. [Post-Installation](#post-installation)
8. [Troubleshooting](#troubleshooting)

---

## Prerequisites

Fresh Arch Linux installation with:
- Base system installed
- User account created with sudo privileges
- Network connectivity
- AUR helper installed (yay or paru)

### Install AUR Helper (if not already installed)
```bash
# Install yay
sudo pacman -S --needed git base-devel
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

---

## Install Required Packages

### 1. Install Core Hyprland Packages
```bash
sudo pacman -S hyprland \
    xdg-desktop-portal-hyprland \
    hyprpaper \
    hyprlock \
    hypridle \
    qt5-wayland \
    qt6-wayland
```

### 2. Install Waybar (Status Bar)
```bash
sudo pacman -S waybar
```

### 3. Install Terminal Emulators
```bash
# Kitty (your custom configured terminal)
sudo pacman -S kitty

# Foot (default in your config)
sudo pacman -S foot
```

### 4. Install Application Launcher
```bash
# Rofi for Wayland
sudo pacman -S rofi-wayland
```

### 5. Install Wallpaper Manager
```bash
# SWWW - Wallpaper daemon for Wayland
sudo pacman -S swww
```

### 6. Install System Utilities
```bash
sudo pacman -S \
    wl-clipboard \
    cliphist \
    swaync \
    network-manager-applet \
    thunar \
    polkit-gnome \
    brightnessctl \
    playerctl \
    pavucontrol \
    grim \
    slurp \
    jq \
    bc \
    socat \
    imagemagick \
    hyprpicker
```

### 7. Install Neovim
```bash
sudo pacman -S neovim git curl
```

### 8. Install Optional Applications
```bash
sudo pacman -S firefox          # Browser
```

### 9. Install AUR Packages
```bash
# Install Quickshell (desktop overview)
yay -S quickshell-git

# Install wallust (color scheme generator)
yay -S wallust

# Install nwg-displays (monitor configuration GUI)
yay -S nwg-displays

# Install HyprFlux if you want the full suite
# yay -S hyprflux-git
```

---

## Install Fonts

### 1. Install JetBrains Mono Nerd Font
```bash
sudo pacman -S ttf-jetbrains-mono-nerd
```

### 2. Install Additional Nerd Fonts (for icons)
```bash
sudo pacman -S ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono
# OR install all nerd fonts (larger download):
# yay -S nerd-fonts-complete
```

### 3. Install Icon Theme
```bash
sudo pacman -S papirus-icon-theme

# Set icon theme
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
```

### 4. Verify Font Installation
```bash
fc-list | grep -i "JetBrains"
```

---

## Deploy Configurations

### 1. Backup Existing Configs (if any)
```bash
# Create backup directory
mkdir -p ~/.config-backup

# Backup existing configs
mv ~/.config/hypr ~/.config-backup/ 2>/dev/null || true
mv ~/.config/waybar ~/.config-backup/ 2>/dev/null || true
mv ~/.config/kitty ~/.config-backup/ 2>/dev/null || true
mv ~/.config/rofi ~/.config-backup/ 2>/dev/null || true
mv ~/.config/nvim ~/.config-backup/ 2>/dev/null || true
```

### 2. Deploy Configuration Files
```bash
# Navigate to your config directory
cd ~/Documents/hyprlandconfig

# Copy Hyprland configs
mkdir -p ~/.config/hypr
cp -r hypr/* ~/.config/hypr/

# Copy Waybar configs
mkdir -p ~/.config/waybar
cp -r waybar/* ~/.config/waybar/

# Create symlinks for waybar config and style
ln -sf ~/.config/waybar/configs/default-config ~/.config/waybar/config
ln -sf ~/.config/waybar/style/default-style.css ~/.config/waybar/style.css

# Copy Kitty config
mkdir -p ~/.config/kitty
cp kitty/kitty.conf ~/.config/kitty/

# Copy Rofi configs
mkdir -p ~/.config/rofi
cp -r rofi/* ~/.config/rofi/

# Copy Neovim/LazyVim config
mkdir -p ~/.config/nvim
cp -r nvim/* ~/.config/nvim/
```

### 3. Make Scripts Executable
```bash
chmod +x ~/.config/hypr/UserScripts/*.sh
chmod +x ~/.config/hypr/scripts/*.sh 2>/dev/null || true
```

---

## Configure Individual Components

### 1. Hyprland Keybindings

Your custom keybindings are in `~/.config/hypr/UserConfigs/UserKeybinds.conf`

Key mappings:
- **SUPER + Return** - Open Kitty terminal
- **SUPER + D** - Open Rofi launcher
- **SUPER + F** - Open file manager (Thunar)
- **SUPER + B** - Open Firefox
- **SUPER SHIFT + W** - Select wallpaper
- **CTRL ALT + W** - Random wallpaper
- **SUPER + V** - Clipboard manager

### 2. Update Terminal Preference

Edit `~/.config/hypr/UserConfigs/01-UserDefaults.conf`:
```bash
# Change terminal from 'foot' to 'kitty' if preferred
$term = kitty  # Change this line

# Or keep as:
$term = foot
```

### 3. Configure Monitors

Your current monitor setup is in `~/.config/hypr/monitors.conf`

To reconfigure on new system:
```bash
# Option 1: Use nwg-displays (GUI)
nwg-displays

# Option 2: Manual configuration
# Edit ~/.config/hypr/monitors.conf
# Format: monitor=DESC,RESxRES@REFRESH,POSITION,SCALE
```

### 4. Setup Wallpapers

Create wallpaper directory:
```bash
mkdir -p ~/Pictures/wallpapers

# Copy your wallpapers to this directory
# The wallpaper scripts expect wallpapers in ~/Pictures/wallpapers/
```

---

## Enable Wallpaper Automation

### 1. Configure Wallpaper Auto-Change

The wallpaper auto-change script is already in your config.

To enable it, edit `~/.config/hypr/UserConfigs/Startup_Apps.conf`:
```bash
# Uncomment this line (remove the #):
exec-once = $SwwwRandom $wallDIR # random wallpaper switcher every 30 minutes
```

### 2. Adjust Wallpaper Change Interval

Edit `~/.config/hypr/UserScripts/WallpaperAutoChange.sh`:
```bash
# Change this value (in seconds):
INTERVAL=1800  # 1800 = 30 minutes
# For 10 minutes: INTERVAL=600
# For 1 hour: INTERVAL=3600
```

---

## Post-Installation

### 1. Start Hyprland

From TTY:
```bash
Hyprland
```

Or add to your login manager.

### 2. Install LazyVim Plugins

On first launch of Neovim:
```bash
nvim
```

LazyVim will automatically install plugins. Wait for completion.

### 3. Enable Services

```bash
# Enable NetworkManager (if not already)
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
```

### 4. Configure Default Applications

Edit `~/.config/hypr/UserConfigs/01-UserDefaults.conf`:
```bash
$term = kitty           # Your preferred terminal
$files = thunar         # Your preferred file manager
$edit = nvim           # Your preferred editor
```

---

## Component-Specific Configuration

### Waybar Customization

Your Waybar shows:
- Dynamic workspaces
- Battery percentage
- Audio volume
- Network status

Configuration files:
- Main config: `~/.config/waybar/configs/default-config`
- Style: `~/.config/waybar/style/default-style.css`
- Modules: `~/.config/waybar/Modules`
- Workspaces: `~/.config/waybar/ModulesWorkspaces`

To customize:
```bash
# Edit the config
nvim ~/.config/waybar/configs/default-config

# Restart waybar
pkill waybar && waybar &
```

### Kitty Terminal Theme

Your Kitty config includes:
- Font: JetBrains Mono Nerd Font, size 14
- Background opacity: 0.80
- Custom color scheme

Config location: `~/.config/kitty/kitty.conf`

To reload Kitty config:
- Press `CTRL + SHIFT + F5` in Kitty
- Or restart Kitty

### Rofi Theme

Your Rofi launcher is themed with custom RASI files.

Config location: `~/.config/rofi/`

To test Rofi:
```bash
rofi -show drun
```

### LazyVim/NvChad

Your Neovim setup uses NvChad framework.

Key features:
- Terminal popup (configured)
- Diagnostic virtual text enabled
- Custom mappings in `~/.config/nvim/lua/`

First-time setup:
```bash
nvim
# Wait for plugins to install
# Press 'q' to close any welcome screens
```

---

## Troubleshooting

### Hyprland Won't Start
```bash
# Check logs
cat /tmp/hypr/$(ls -t /tmp/hypr | head -1)/hyprland.log

# Verify installation
which Hyprland
```

### Waybar Not Showing
```bash
# Check if waybar is running
pgrep waybar

# Start manually
waybar

# Check for errors
journalctl --user -u waybar
```

### No Sound in Waybar
```bash
# Install PipeWire
sudo pacman -S pipewire pipewire-pulse wireplumber
systemctl --user enable pipewire pipewire-pulse wireplumber
systemctl --user start pipewire pipewire-pulse wireplumber
```

### Wallpaper Not Changing
```bash
# Verify swww is running
pgrep swww

# Start swww daemon
swww-daemon --format xrgb

# Check wallpaper directory
ls ~/Pictures/wallpapers/

# Test wallpaper script
~/.config/hypr/UserScripts/WallpaperRandom.sh ~/Pictures/wallpapers/
```

### Rofi Not Working
```bash
# Test rofi
rofi -show drun -modi drun,run,window

# Check rofi config
cat ~/.config/rofi/config.rasi
```

### Clipboard Manager Not Working
```bash
# Start clipboard manager
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
```

### Icons Not Showing in Waybar
```bash
# Verify nerd fonts are installed
fc-list | grep -i nerd

# Reinstall fonts
sudo pacman -S ttf-nerd-fonts-symbols
fc-cache -fv
```

---

## Directory Structure Reference

```
~/Documents/hyprlandconfig/
├── hypr/
│   ├── hyprland.conf           # Main Hyprland config
│   ├── monitors.conf           # Monitor configuration
│   ├── workspaces.conf         # Workspace rules
│   ├── hypridle.conf           # Idle configuration
│   ├── hyprlock.conf           # Lock screen config
│   ├── UserConfigs/
│   │   ├── UserKeybinds.conf   # Your custom keybindings
│   │   ├── Startup_Apps.conf   # Apps to start on boot
│   │   ├── 01-UserDefaults.conf # Default apps
│   │   ├── ENVariables.conf    # Environment variables
│   │   ├── UserSettings.conf   # Hyprland settings
│   │   └── ...
│   ├── UserScripts/
│   │   ├── WallpaperAutoChange.sh  # Auto wallpaper changer
│   │   └── ...
│   └── scripts/
│       └── ...
├── waybar/
│   ├── Modules                 # Waybar modules definition
│   ├── ModulesWorkspaces       # Workspace module config
│   ├── configs/
│   │   └── default-config      # Your active waybar config
│   └── style/
│       └── default-style.css   # Your active waybar style
├── kitty/
│   └── kitty.conf              # Kitty terminal config
├── rofi/
│   ├── config.rasi             # Rofi main config
│   ├── master-config.rasi      # Rofi theme config
│   └── ...
├── nvim/
│   ├── init.lua                # NvChad/LazyVim init
│   └── lua/                    # Neovim Lua configs
├── fonts/
│   └── FONTS.md                # Font installation guide
├── docs/
│   ├── SETUP-GUIDE.md          # This guide
│   └── PACKAGES.md             # Package list
└── scripts/
    └── ...
```

---

## Quick Reference Commands

```bash
# Reload Hyprland config
hyprctl reload

# Restart Waybar
pkill waybar && waybar &

# Toggle Waybar visibility
pkill -SIGUSR1 waybar

# Change wallpaper randomly
~/.config/hypr/UserScripts/WallpaperRandom.sh ~/Pictures/wallpapers/

# Select specific wallpaper
~/.config/hypr/UserScripts/WallpaperSelect.sh

# Open clipboard manager
~/.config/hypr/scripts/ClipManager.sh

# Show keybind hints
~/.config/hypr/scripts/KeyHints.sh
```

---

## Additional Resources

- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Waybar Configuration](https://github.com/Alexays/Waybar/wiki)
- [Rofi Documentation](https://github.com/davatorium/rofi)
- [NvChad Documentation](https://nvchad.com/)
- [Arch Wiki - Hyprland](https://wiki.archlinux.org/title/Hyprland)

---

**Note:** This configuration is extracted from your current system. Some paths or features may need adjustment based on your specific setup preferences.

For questions or issues, refer to the original HyprFlux repository: https://github.com/JaKooLit/Hyprland-Dots
