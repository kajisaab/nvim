# Simple Deployment Guide (TL;DR Version)

For those who want the **quickest path** to deploy on fresh Arch Linux.

---

## What is ENVariables.conf?

**In Simple Terms:** It tells applications how to work with Wayland instead of X11.

**Without it:** Apps would be slow, blurry, and broken.

**With it:** Apps run natively on Wayland with proper scaling and hardware acceleration.

---

## 5-Phase Deployment

### PHASE 1: Install Packages (15 minutes)

```bash
# Update system
sudo pacman -Syu

# Install AUR helper
sudo pacman -S --needed git base-devel
cd /tmp && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

# Install EVERYTHING at once
sudo pacman -S hyprland xdg-desktop-portal-hyprland qt5-wayland qt6-wayland \
    hyprpaper hyprlock hypridle polkit-kde-agent waybar kitty foot \
    rofi-wayland swww wl-clipboard cliphist swaync network-manager-applet \
    blueman thunar gvfs thunar-volman tumbler brightnessctl playerctl \
    pavucontrol pamixer grim slurp jq bc socat imagemagick hyprpicker \
    polkit-gnome ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols \
    ttf-nerd-fonts-symbols-mono papirus-icon-theme neovim firefox

# Install AUR packages
yay -S quickshell-git wallust nwg-displays

# Set icon theme
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
```

### PHASE 2: Copy Config Folder (2 minutes)

```bash
# Copy your hyprlandconfig folder to new system
# (via USB, SCP, Git, etc.)

# Example using USB:
cp -r /media/usb/hyprlandconfig ~/Documents/

# Or using Git:
git clone YOUR_REPO_URL ~/Documents/hyprlandconfig
```

### PHASE 3: Deploy Configs (1 minute)

```bash
cd ~/Documents/hyprlandconfig
chmod +x deploy-configs.sh
./deploy-configs.sh
```

### PHASE 4: Setup Wallpapers & Monitors (5 minutes)

```bash
# Copy wallpapers
mkdir -p ~/Pictures/wallpapers
cp /path/to/your/wallpapers/* ~/Pictures/wallpapers/

# Configure monitors (IMPORTANT!)
nwg-displays
# Use GUI to arrange monitors and save

# OR manually edit:
nano ~/.config/hypr/monitors.conf
```

### PHASE 5: Start Hyprland (1 second)

```bash
Hyprland
```

---

## That's It!

Press `SUPER + Return` to open terminal and verify everything works.

---

## If Something Breaks

### Waybar not showing?
```bash
waybar &
```

### No sound?
```bash
sudo pacman -S pipewire pipewire-pulse wireplumber
systemctl --user enable --now pipewire pipewire-pulse wireplumber
```

### Icons missing?
```bash
fc-cache -fv
pkill waybar && waybar &
```

### Wallpaper not working?
```bash
swww-daemon --format xrgb &
swww img ~/Pictures/wallpapers/yourimage.jpg
```

### Apps look blurry? (HiDPI displays)
```bash
nano ~/.config/hypr/UserConfigs/ENVariables.conf
# Change:
env = GDK_SCALE,2          # 2 = 200% scaling
env = QT_SCALE_FACTOR,2    # adjust as needed
```

Then:
```bash
hyprctl reload
```

---

## Automatic Login to Hyprland (Optional)

Add to `~/.bash_profile`:
```bash
if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec Hyprland
fi
```

---

## Total Time: ~25 minutes

- 15 min: Package installation
- 2 min: Copy configs
- 1 min: Deploy script
- 5 min: Wallpapers & monitors
- 2 min: Verification

**Done!** You have a fully configured Hyprland system.

---

## Essential Keybindings

Once Hyprland is running:

- `SUPER + Return` → Terminal
- `SUPER + D` → App launcher
- `SUPER + F` → File manager
- `SUPER + Q` → Close window
- `SUPER + 1-9` → Switch workspace

See `QUICK-REFERENCE.md` for complete list.

---

## What ENVariables.conf Actually Does

```bash
# Makes GTK apps use Wayland
env = GDK_BACKEND,wayland,x11,*

# Makes Qt apps use Wayland
env = QT_QPA_PLATFORM,wayland;xcb

# Tells apps which desktop environment
env = XDG_CURRENT_DESKTOP,Hyprland
env = XDG_SESSION_TYPE,wayland

# Fixes HiDPI scaling
env = GDK_SCALE,1
env = QT_SCALE_FACTOR,1

# Makes Firefox use Wayland
env = MOZ_ENABLE_WAYLAND,1

# Makes Electron apps (VS Code, Discord) use Wayland
env = ELECTRON_OZONE_PLATFORM_HINT,auto

# Sets cursor theme
env = HYPRCURSOR_THEME,Bibata-Modern-Classic
env = HYPRCURSOR_SIZE,20
```

**Bottom line:** These variables ensure apps run fast and look good on Wayland.

---

For detailed explanations, see `DEPLOYMENT-GUIDE.md`
