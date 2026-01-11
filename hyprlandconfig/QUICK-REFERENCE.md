# Quick Reference Card

## Essential Keybindings

### Applications
| Key Combo | Action |
|-----------|--------|
| `SUPER + Return` | Open Kitty terminal |
| `SUPER + D` | Rofi launcher |
| `SUPER + F` | File manager (Thunar) |
| `SUPER + B` | Firefox browser |
| `SUPER + C` | VS Code |
| `SUPER + O` | Obsidian |
| `SUPER + S` | Spotify |
| `SUPER + E` | Tmuxifier session |

### System Control
| Key Combo | Action |
|-----------|--------|
| `SUPER + V` | Clipboard manager |
| `SUPER SHIFT + R` | Refresh Waybar/Rofi |
| `SUPER SHIFT + H` | Show keybind hints |
| `SUPER CTRL ALT + B` | Toggle Waybar visibility |
| `SUPER SHIFT + F` | Fullscreen |
| `SUPER + SPACE` | Toggle floating |

### Wallpaper
| Key Combo | Action |
|-----------|--------|
| `SUPER SHIFT + W` | Select wallpaper |
| `CTRL ALT + W` | Random wallpaper |

### Window Management
| Key Combo | Action |
|-----------|--------|
| `SUPER + Q` | Close window |
| `SUPER + Arrow Keys` | Move focus |
| `SUPER + 1-9` | Switch to workspace |
| `SUPER SHIFT + 1-9` | Move window to workspace |

---

## Quick Setup Commands

### On Fresh Install

```bash
# 1. Install core packages
sudo pacman -S hyprland waybar kitty rofi-wayland swww neovim

# 2. Install fonts
sudo pacman -S ttf-jetbrains-mono-nerd

# 3. Deploy configs
cd ~/Documents/hyprlandconfig
chmod +x deploy-configs.sh
./deploy-configs.sh

# 4. Copy wallpapers
cp wallpapers/* ~/Pictures/wallpapers/

# 5. Start Hyprland
Hyprland
```

### On Current System (Re-extract)

```bash
cd ~/Documents/hyprlandconfig
./extract-configs.sh
```

---

## Config File Locations

```
~/.config/hypr/hyprland.conf              # Main config
~/.config/hypr/UserConfigs/UserKeybinds.conf  # Keybindings
~/.config/hypr/UserConfigs/Startup_Apps.conf  # Startup apps
~/.config/waybar/config                    # Waybar layout
~/.config/waybar/style.css                 # Waybar theme
~/.config/kitty/kitty.conf                 # Kitty config
~/.config/rofi/config.rasi                 # Rofi config
~/.config/nvim/init.lua                    # Neovim config
```

---

## Quick Customizations

### Change Wallpaper Interval
```bash
nano ~/.config/hypr/UserScripts/WallpaperAutoChange.sh
# Edit line: INTERVAL=1800 (seconds)
```

### Change Default Terminal
```bash
nano ~/.config/hypr/UserConfigs/01-UserDefaults.conf
# Edit line: $term = kitty
```

### Enable Wallpaper Auto-Change
```bash
nano ~/.config/hypr/UserConfigs/Startup_Apps.conf
# Uncomment: exec-once = $SwwwRandom $wallDIR
```

### Adjust Kitty Opacity
```bash
nano ~/.config/kitty/kitty.conf
# Edit line: background_opacity 0.80
```

### Reload Configs
```bash
hyprctl reload              # Reload Hyprland
pkill waybar && waybar &    # Restart Waybar
pkill -SIGUSR1 waybar       # Toggle Waybar
```

---

## Troubleshooting

### Waybar not showing
```bash
pgrep waybar || waybar &
```

### No sound
```bash
sudo pacman -S pipewire pipewire-pulse wireplumber
systemctl --user start pipewire pipewire-pulse
```

### Icons missing
```bash
sudo pacman -S ttf-nerd-fonts-symbols
fc-cache -fv
```

### Wallpaper not working
```bash
swww-daemon --format xrgb &
swww img ~/Pictures/wallpapers/your-image.jpg
```

### Monitor issues
```bash
nwg-displays    # GUI tool
# Or edit: ~/.config/hypr/monitors.conf
```

---

## File Paths Reference

```
Configs source: ~/Documents/hyprlandconfig/
Wallpapers:     ~/Pictures/wallpapers/
Config deploy:  ~/.config/
Hypr configs:   ~/.config/hypr/
```

---

## Package Install Commands

```bash
# Core
sudo pacman -S hyprland waybar kitty foot rofi-wayland swww neovim

# Utilities
sudo pacman -S wl-clipboard cliphist swaync network-manager-applet \
    thunar brightnessctl playerctl pavucontrol grim slurp \
    hyprpicker imagemagick

# Fonts
sudo pacman -S ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols

# Icons
sudo pacman -S papirus-icon-theme

# AUR (with yay)
yay -S quickshell-git wallust nwg-displays
```

---

## Useful Commands

```bash
# Hyprland
hyprctl monitors                 # List monitors
hyprctl workspaces              # List workspaces
hyprctl clients                 # List windows
hyprctl reload                  # Reload config

# Waybar
pkill waybar && waybar &        # Restart
pkill -SIGUSR1 waybar          # Toggle

# Wallpaper
swww img /path/to/image.jpg    # Set wallpaper
~/.config/hypr/UserScripts/WallpaperRandom.sh ~/Pictures/wallpapers/

# Clipboard
cliphist list                   # Show history
cliphist list | rofi -dmenu | cliphist decode | wl-copy

# System
fc-cache -fv                    # Refresh font cache
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
```

---

## Important Directories

```
~/Documents/hyprlandconfig/          # Backup configs
~/Pictures/wallpapers/               # Wallpapers
~/.config/hypr/                      # Hyprland config
~/.config/waybar/                    # Waybar config
~/.config/kitty/                     # Kitty config
~/.config/rofi/                      # Rofi config
~/.config/nvim/                      # Neovim config
```

---

## Support

- Full guide: `~/Documents/hyprlandconfig/docs/SETUP-GUIDE.md`
- Packages: `~/Documents/hyprlandconfig/docs/PACKAGES.md`
- Summary: `~/Documents/hyprlandconfig/EXTRACTION-SUMMARY.md`
- HyprFlux: https://github.com/JaKooLit/Hyprland-Dots
- Hyprland Wiki: https://wiki.hyprland.org/

---

**Print this card or bookmark for quick access!**
