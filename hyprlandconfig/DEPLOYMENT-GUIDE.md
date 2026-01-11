# Complete Deployment Guide for Fresh Arch Linux Install

This guide walks you through deploying your HyprFlux/Hyprland configuration on a **fresh Arch Linux installation**.

---

## What is ENVariables.conf?

**ENVariables.conf** sets **environment variables** that tell applications how to work properly with Wayland/Hyprland. It configures:

### 1. **Toolkit Backends** (lines 7-10)
```bash
env = GDK_BACKEND,wayland,x11,*        # GTK apps use Wayland first
env = QT_QPA_PLATFORM,wayland;xcb      # Qt apps use Wayland
env = CLUTTER_BACKEND,wayland          # Clutter apps use Wayland
```
**Why:** Tells GTK and Qt applications to run natively on Wayland instead of XWayland (better performance)

### 2. **XDG Desktop Specifications** (lines 16-19)
```bash
env = XDG_CURRENT_DESKTOP,Hyprland
env = XDG_SESSION_DESKTOP,Hyprland
env = XDG_SESSION_TYPE,wayland
```
**Why:** Tells applications which desktop environment and display protocol you're using

### 3. **Qt Application Settings** (lines 21-28)
```bash
env = QT_AUTO_SCREEN_SCALE_FACTOR,1    # Auto-scale Qt apps
env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1  # Disable Qt window decorations
env = QT_QPA_PLATFORMTHEME,qt5ct       # Qt5 theme engine
```
**Why:** Makes Qt applications (like VS Code, Dolphin) look correct and scale properly

### 4. **HiDPI Scaling** (lines 30-35)
```bash
env = GDK_SCALE,1        # GTK scaling (1 = 100%, 2 = 200%)
env = QT_SCALE_FACTOR,1  # Qt scaling
```
**Why:** Fix blurry apps on high-DPI displays (adjust if using 4K/HiDPI monitors)

### 5. **Cursor Theme** (lines 37-41)
```bash
env = HYPRCURSOR_THEME,Bibata-Modern-Classic
env = HYPRCURSOR_SIZE,20
```
**Why:** Sets your cursor theme and size

### 6. **Firefox Wayland** (line 44)
```bash
env = MOZ_ENABLE_WAYLAND,1
```
**Why:** Makes Firefox run natively on Wayland (better performance, touch gestures)

### 7. **Electron Apps** (line 48)
```bash
env = ELECTRON_OZONE_PLATFORM_HINT,auto
```
**Why:** Makes Electron apps (VS Code, Discord, Obsidian) use Wayland when possible

### 8. **NVIDIA Settings** (lines 50-75, commented out)
If you have an NVIDIA GPU, uncomment relevant lines for better compatibility.

---

## Step-by-Step Deployment on Fresh Arch Install

### Prerequisites

You should have:
- [ ] Fresh Arch Linux installed
- [ ] Working internet connection
- [ ] User account with sudo privileges
- [ ] Booted into TTY (no GUI yet)

---

### PHASE 1: Base System Setup

#### 1.1 Update System
```bash
sudo pacman -Syu
```

#### 1.2 Install AUR Helper (yay)
```bash
sudo pacman -S --needed git base-devel

cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

---

### PHASE 2: Install All Required Packages

#### 2.1 Install Hyprland and Core Components
```bash
sudo pacman -S hyprland \
    xdg-desktop-portal-hyprland \
    qt5-wayland \
    qt6-wayland \
    hyprpaper \
    hyprlock \
    hypridle \
    polkit-kde-agent
```

#### 2.2 Install Waybar (Status Bar)
```bash
sudo pacman -S waybar
```

#### 2.3 Install Terminals
```bash
# Install both (config uses foot by default, but kitty is configured)
sudo pacman -S kitty foot
```

#### 2.4 Install Rofi and Wallpaper Manager
```bash
sudo pacman -S rofi-wayland swww
```

#### 2.5 Install System Utilities
```bash
sudo pacman -S \
    wl-clipboard \
    cliphist \
    swaync \
    network-manager-applet \
    blueman \
    thunar \
    gvfs \
    thunar-volman \
    tumbler \
    brightnessctl \
    playerctl \
    pavucontrol \
    pamixer \
    grim \
    slurp \
    jq \
    bc \
    socat \
    imagemagick \
    hyprpicker \
    polkit-gnome
```

#### 2.6 Install Fonts
```bash
# JetBrains Mono Nerd Font (required for Kitty)
sudo pacman -S ttf-jetbrains-mono-nerd

# Additional Nerd Fonts for icons
sudo pacman -S ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono

# Or install all nerd fonts (larger)
# yay -S nerd-fonts-complete
```

#### 2.7 Install Icon Theme
```bash
sudo pacman -S papirus-icon-theme

# Set icon theme
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
```

#### 2.8 Install Neovim
```bash
sudo pacman -S neovim
```

#### 2.9 Install Optional Applications
```bash
# Browser
sudo pacman -S firefox

# Optional: More file managers
sudo pacman -S dolphin

# Optional: More terminals
sudo pacman -S alacritty
```

#### 2.10 Install AUR Packages
```bash
# Quickshell (desktop overview - used in your config)
yay -S quickshell-git

# Wallust (color scheme generator from wallpapers)
yay -S wallust

# Monitor configuration GUI
yay -S nwg-displays

# Optional: Full HyprFlux suite
# yay -S hyprflux-git
```

#### 2.11 Verify Font Installation
```bash
fc-list | grep -i "JetBrains"
# Should show JetBrains Mono Nerd Font
```

---

### PHASE 3: Copy Your Configuration Files

#### 3.1 Transfer Config Folder to New System

**Option A: Using USB Drive**
```bash
# On old system (copy to USB)
cp -r ~/Documents/hyprlandconfig /media/usb/

# On new system (copy from USB)
mkdir -p ~/Documents/
cp -r /media/usb/hyprlandconfig ~/Documents/
```

**Option B: Using Git**
```bash
# On old system
cd ~/Documents/hyprlandconfig
git init
git add .
git commit -m "My Hyprland config"
# Push to GitHub/GitLab

# On new system
git clone YOUR_REPO_URL ~/Documents/hyprlandconfig
```

**Option C: Using SCP (if both systems on network)**
```bash
# On new system
scp -r user@old-system-ip:~/Documents/hyprlandconfig ~/Documents/
```

#### 3.2 Navigate to Config Directory
```bash
cd ~/Documents/hyprlandconfig
```

#### 3.3 Run Deployment Script
```bash
chmod +x deploy-configs.sh
./deploy-configs.sh
```

The script will:
- ✅ Backup any existing configs
- ✅ Copy all Hyprland configs to `~/.config/hypr/`
- ✅ Copy Waybar configs to `~/.config/waybar/`
- ✅ Copy Kitty config to `~/.config/kitty/`
- ✅ Copy Rofi configs to `~/.config/rofi/`
- ✅ Copy Neovim configs to `~/.config/nvim/`
- ✅ Make scripts executable
- ✅ Create wallpaper directory

---

### PHASE 4: Post-Deployment Configuration

#### 4.1 Setup Wallpapers
```bash
# Create wallpaper directory (already done by deploy script)
mkdir -p ~/Pictures/wallpapers

# Copy your wallpapers
# If you have them on USB:
cp /media/usb/wallpapers/* ~/Pictures/wallpapers/

# Or download some:
# wget -P ~/Pictures/wallpapers/ https://example.com/wallpaper.jpg
```

#### 4.2 Configure Monitors (Important!)

Your old monitor config won't match the new system. You need to reconfigure:

**Option A: GUI Tool (Recommended)**
```bash
nwg-displays
# Use the GUI to arrange your monitors
# Save the configuration
```

**Option B: Manual Configuration**
```bash
# First, see available monitors
hyprctl monitors

# Edit monitor config
nano ~/.config/hypr/monitors.conf

# Example format:
# monitor=HDMI-A-1,1920x1080@60,0x0,1
# monitor=DP-1,2560x1440@144,1920x0,1
```

#### 4.3 Adjust Default Applications

Edit your default apps:
```bash
nano ~/.config/hypr/UserConfigs/01-UserDefaults.conf
```

Change these if needed:
```bash
$term = kitty      # or foot, alacritty
$files = thunar    # or dolphin, nautilus
$edit = nvim       # or vim, code
```

#### 4.4 Enable Wallpaper Auto-Change (Optional)

```bash
nano ~/.config/hypr/UserConfigs/Startup_Apps.conf
```

Find this line and uncomment it (remove the `#`):
```bash
exec-once = $SwwwRandom $wallDIR # random wallpaper switcher every 30 minutes
```

#### 4.5 Install Neovim Plugins

```bash
# Just open neovim, it will auto-install plugins
nvim

# Wait for LazyVim to install everything
# Then close: :q
```

---

### PHASE 5: Start Hyprland

#### 5.1 From TTY
```bash
Hyprland
```

#### 5.2 Auto-Start on Login (Optional)

Add to `~/.bash_profile` or `~/.zprofile`:
```bash
if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec Hyprland
fi
```

---

### PHASE 6: First Boot Verification

#### 6.1 Check if Everything is Running
```bash
# Waybar should be visible at the top
pgrep waybar

# SWWW wallpaper daemon
pgrep swww

# Notification daemon
pgrep swaync

# Network applet
pgrep nm-applet
```

#### 6.2 Test Keybindings

| Test | Keybinding | Expected Result |
|------|------------|-----------------|
| Terminal | `SUPER + Return` | Kitty opens |
| Launcher | `SUPER + D` | Rofi appears |
| File Manager | `SUPER + F` | Thunar opens |
| Wallpaper | `CTRL + ALT + W` | Wallpaper changes |

#### 6.3 Test Waybar Modules

Check if these show correctly:
- [ ] Workspaces (click to switch)
- [ ] Battery percentage (if laptop)
- [ ] Volume percentage
- [ ] Network status
- [ ] Clock

---

## Troubleshooting Common Issues

### Issue 1: Waybar Not Showing
```bash
# Check if running
pgrep waybar

# If not, start it
waybar &

# Check for errors
journalctl --user -xe | grep waybar
```

### Issue 2: No Sound/Volume Control
```bash
# Install PipeWire if not already
sudo pacman -S pipewire pipewire-pulse pipewire-alsa wireplumber

# Start PipeWire
systemctl --user enable --now pipewire pipewire-pulse wireplumber

# Restart Hyprland
```

### Issue 3: Icons Not Showing in Waybar
```bash
# Refresh font cache
fc-cache -fv

# Check nerd fonts installed
fc-list | grep -i nerd

# Restart waybar
pkill waybar && waybar &
```

### Issue 4: Wallpaper Not Working
```bash
# Start SWWW daemon
swww-daemon --format xrgb &

# Test wallpaper
swww img ~/Pictures/wallpapers/your-image.jpg

# Check if wallpapers exist
ls ~/Pictures/wallpapers/
```

### Issue 5: Rofi Won't Open
```bash
# Test rofi manually
rofi -show drun

# If error, check config
cat ~/.config/rofi/config.rasi

# Ensure rofi-wayland is installed
pacman -Qi rofi-wayland
```

### Issue 6: Applications Look Blurry (HiDPI)

Edit `~/.config/hypr/UserConfigs/ENVariables.conf`:
```bash
# For 2x scaling (200%):
env = GDK_SCALE,2
env = QT_SCALE_FACTOR,2

# For 1.5x scaling (150%):
env = GDK_SCALE,1.5
env = QT_SCALE_FACTOR,1.5
```

Then reload Hyprland: `hyprctl reload`

### Issue 7: NVIDIA Graphics Issues

If you have NVIDIA GPU, edit `~/.config/hypr/UserConfigs/ENVariables.conf` and uncomment these lines:
```bash
env = LIBVA_DRIVER_NAME,nvidia
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
env = NVD_BACKEND,direct
```

Also install NVIDIA packages:
```bash
sudo pacman -S nvidia nvidia-utils nvidia-settings
```

### Issue 8: Electron Apps (VS Code, Discord) Not Working

They should work with this line in ENVariables.conf:
```bash
env = ELECTRON_OZONE_PLATFORM_HINT,auto
```

If still issues, launch with flags:
```bash
code --enable-features=UseOzonePlatform --ozone-platform=wayland
```

---

## Quick Setup Checklist

Use this to verify your deployment:

- [ ] Arch Linux installed and updated
- [ ] Yay AUR helper installed
- [ ] All packages from Phase 2 installed
- [ ] Fonts installed and verified
- [ ] Config folder copied to new system
- [ ] Deploy script executed successfully
- [ ] Wallpapers copied to ~/Pictures/wallpapers/
- [ ] Monitors configured for new system
- [ ] Default apps configured
- [ ] Hyprland starts without errors
- [ ] Waybar shows at top
- [ ] Keybindings work
- [ ] Rofi launcher works
- [ ] Terminal opens
- [ ] Icons display correctly
- [ ] Wallpaper shows

---

## Environment Variables Quick Reference

What ENVariables.conf does line-by-line:

| Variable | Value | Purpose |
|----------|-------|---------|
| `GDK_BACKEND` | wayland,x11 | GTK apps use Wayland |
| `QT_QPA_PLATFORM` | wayland;xcb | Qt apps use Wayland |
| `XDG_CURRENT_DESKTOP` | Hyprland | Tell apps which DE |
| `XDG_SESSION_TYPE` | wayland | Tell apps it's Wayland |
| `QT_AUTO_SCREEN_SCALE_FACTOR` | 1 | Auto-scale Qt apps |
| `GDK_SCALE` | 1 | GTK scaling (change for HiDPI) |
| `QT_SCALE_FACTOR` | 1 | Qt scaling (change for HiDPI) |
| `HYPRCURSOR_THEME` | Bibata-Modern-Classic | Cursor theme |
| `HYPRCURSOR_SIZE` | 20 | Cursor size |
| `MOZ_ENABLE_WAYLAND` | 1 | Firefox on Wayland |
| `ELECTRON_OZONE_PLATFORM_HINT` | auto | Electron apps use Wayland |

---

## Summary

**ENVariables.conf** is critical because it:
1. Tells applications to use Wayland instead of X11
2. Fixes scaling for HiDPI displays
3. Enables hardware acceleration
4. Sets cursor and theme preferences
5. Configures toolkit backends (GTK, Qt, Electron)

Without it, apps would:
- Run through XWayland (slower)
- Look blurry on HiDPI screens
- Have incorrect window decorations
- Not follow system themes

**Deployment is simple:**
1. Install packages (Phase 2)
2. Copy configs with deploy script (Phase 3)
3. Configure monitors (Phase 4)
4. Start Hyprland (Phase 5)

The environment variables are automatically loaded when Hyprland starts because they're sourced in `hyprland.conf`.

---

**Need Help?** See:
- Full Setup Guide: `docs/SETUP-GUIDE.md`
- Quick Reference: `QUICK-REFERENCE.md`
- Hyprland Wiki: https://wiki.hyprland.org/
