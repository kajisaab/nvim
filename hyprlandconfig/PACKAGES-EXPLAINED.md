# Package Requirements Explained

## Question 1: Why Do I Need AUR (yay)? Can't I Just Use pacman?

**Short Answer:** Most packages ARE available via pacman. AUR is only needed for a few specific packages.

### Packages ONLY in AUR (Need yay/paru)

These are NOT in official Arch repos:

| Package | Why AUR Only | Can You Skip It? |
|---------|--------------|------------------|
| `quickshell-git` | Bleeding edge, git version | ⚠️ No - Used in your config for desktop overview |
| `wallust` | Community tool, not official | ✅ Yes - Only for color schemes from wallpapers |
| `nwg-displays` | Community GUI tool | ✅ Yes - You can configure monitors manually |
| SDDM themes (some) | Community themes | ✅ Yes - Use default SDDM or TTY login |

### Can You Avoid AUR Entirely?

**Yes!** Here's the minimal setup WITHOUT AUR:

```bash
# Install ONLY from official repos
sudo pacman -S hyprland waybar kitty rofi-wayland swww neovim \
    xdg-desktop-portal-hyprland qt5-wayland qt6-wayland \
    wl-clipboard brightnessctl playerctl pavucontrol \
    swaync network-manager-applet thunar firefox \
    ttf-jetbrains-mono-nerd papirus-icon-theme sddm

# Skip these AUR packages:
# - quickshell-git → Use AGS or no desktop overview
# - wallust → Color schemes work without it
# - nwg-displays → Configure monitors in monitors.conf manually
```

**Trade-offs:**
- ✅ No AUR helper needed
- ✅ Simpler, more stable
- ❌ No desktop overview (quickshell)
- ❌ Manual monitor configuration
- ❌ No wallpaper-based color schemes

### If You Want AUR (Recommended for Full Experience)

```bash
# Install yay (one-time setup)
sudo pacman -S --needed git base-devel
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Then you can install AUR packages
yay -S quickshell-git nwg-displays wallust
```

**Benefits:**
- ✅ Full feature set from your config
- ✅ Desktop overview works
- ✅ GUI monitor configuration
- ✅ Dynamic color schemes

---

## Question 2: Why These Packages If I Already Have GNOME/Wayland?

**Key Point:** GNOME and Hyprland are **DIFFERENT** desktop environments. They don't share all components.

### What GNOME Already Installed

When you have GNOME on Wayland, you have:

| GNOME Package | Purpose |
|---------------|---------|
| `gnome-shell` | GNOME's compositor |
| `mutter` | GNOME's window manager |
| `xdg-desktop-portal-gnome` | GNOME's portal (file picker, screen sharing) |
| Possibly `qt5-wayland`, `qt6-wayland` | For Qt apps on Wayland |
| `wayland` libraries | Core Wayland support |

### What You STILL Need for Hyprland

Even with GNOME installed, Hyprland needs:

#### 1. **xdg-desktop-portal-hyprland** (Different from GNOME's portal)

```bash
sudo pacman -S xdg-desktop-portal-hyprland
```

**Why?**
- GNOME has: `xdg-desktop-portal-gnome`
- Hyprland needs: `xdg-desktop-portal-hyprland`
- They're **separate implementations** for different compositors
- Handles: screen sharing, file pickers, screen capture in Hyprland

**What happens if you skip it?**
- Screen sharing won't work (Zoom, Discord, OBS)
- Some file picker dialogs may break
- XWayland apps may have issues

#### 2. **qt5-wayland & qt6-wayland** (Might already have)

```bash
sudo pacman -S qt5-wayland qt6-wayland
```

**Why?**
- Qt apps (VS Code, Telegram, Dolphin) need these to run on Wayland
- GNOME might have installed these already
- Check first: `pacman -Qi qt5-wayland`

**What happens if you skip it?**
- Qt apps will run through XWayland (slower)
- Apps might look blurry
- No native Wayland benefits for Qt apps

#### 3. **hyprland** (Obviously different from GNOME)

```bash
sudo pacman -S hyprland
```

**Why?**
- Hyprland is the compositor itself
- Completely separate from GNOME/mutter
- GNOME doesn't include Hyprland

---

## GNOME vs Hyprland: What Changes?

### When You Switch from GNOME to Hyprland

| Component | GNOME | Hyprland |
|-----------|-------|----------|
| **Compositor** | mutter | hyprland |
| **Desktop Shell** | gnome-shell | waybar + rofi |
| **Portal** | xdg-desktop-portal-gnome | xdg-desktop-portal-hyprland |
| **Window Manager** | Built into mutter | Built into hyprland |
| **Notifications** | gnome-shell | swaync |
| **App Launcher** | GNOME Overview | rofi |
| **Status Bar** | GNOME top bar | waybar |
| **Settings** | GNOME Settings | Manual config files |
| **Login Manager** | GDM (optional) | SDDM (or keep GDM) |

### What You Can Keep from GNOME

- ✅ GDM (GNOME Display Manager) - can launch Hyprland
- ✅ GNOME apps (Nautilus, GNOME Terminal, etc.)
- ✅ GTK themes
- ✅ Wayland libraries
- ✅ NetworkManager
- ✅ qt5-wayland, qt6-wayland (if installed)

### What You Must Install for Hyprland

- ✅ hyprland (the compositor)
- ✅ xdg-desktop-portal-hyprland (Hyprland's portal)
- ✅ waybar (status bar)
- ✅ rofi-wayland (app launcher)
- ✅ swww (wallpaper daemon)
- ✅ swaync (notification daemon)

---

## Optimized Package List (Assuming You Have GNOME)

### Already Installed via GNOME (Skip These)

```bash
# You already have these:
# - wayland
# - wayland-protocols
# - xwayland
# - NetworkManager (and nm-applet possibly)
# - gtk3, gtk4
# - Most fonts
# - firefox (if you installed it with GNOME)
# - qt5-wayland, qt6-wayland (maybe, check first)
```

### Check What You Already Have

```bash
# Check if qt-wayland is installed
pacman -Qi qt5-wayland qt6-wayland

# Check if already installed
pacman -Qi | grep -E "Name.*:(hyprland|waybar|rofi)"
```

### Minimal Install for Hyprland (On Top of GNOME)

```bash
# Core Hyprland (REQUIRED)
sudo pacman -S hyprland xdg-desktop-portal-hyprland

# Only install qt-wayland if you don't have it
sudo pacman -S qt5-wayland qt6-wayland

# Hyprland components (REQUIRED)
sudo pacman -S waybar rofi-wayland swww swaync

# Hyprland utilities (REQUIRED for your config)
sudo pacman -S hyprlock hypridle hyprpicker

# Your config needs these
sudo pacman -S kitty wl-clipboard brightnessctl playerctl

# If you want SDDM instead of GDM
sudo pacman -S sddm  # Optional, you can keep GDM

# Fonts (if not already installed)
sudo pacman -S ttf-jetbrains-mono-nerd
```

### Optional (AUR)

```bash
# Only if you want the full experience
yay -S quickshell-git nwg-displays wallust
```

---

## Can I Use GDM (GNOME Display Manager) with Hyprland?

**YES!** You don't need SDDM. GDM can launch Hyprland.

### Keep Using GDM

```bash
# Hyprland will appear in GDM's session selector automatically
# Just select "Hyprland" instead of "GNOME" at login
```

### Or Switch to SDDM (Optional)

```bash
sudo pacman -S sddm
sudo systemctl disable gdm
sudo systemctl enable sddm
```

---

## Comparison: pacman vs AUR

### Official Repos (pacman) - Recommended

**Advantages:**
- ✅ Maintained by Arch developers
- ✅ Signed packages (more secure)
- ✅ Automatic updates with `pacman -Syu`
- ✅ Higher quality control
- ✅ Faster installation

**All Core Hyprland Components Are in Official Repos:**
- hyprland
- waybar
- rofi-wayland
- kitty
- swww
- xdg-desktop-portal-hyprland

### AUR (yay/paru) - Optional

**Advantages:**
- ✅ More packages available
- ✅ Bleeding edge versions (git packages)
- ✅ Community tools

**Disadvantages:**
- ⚠️ Community maintained (less oversight)
- ⚠️ Build from source (slower)
- ⚠️ Potential security risk (review PKGBUILDs)
- ⚠️ Can break on updates

**AUR Packages in Your Config:**
- `quickshell-git` - Desktop overview
- `nwg-displays` - Monitor GUI
- `wallust` - Color scheme tool

---

## Minimal Setup Without AUR

### Step 1: Install Core Packages (pacman only)

```bash
sudo pacman -S hyprland xdg-desktop-portal-hyprland \
    qt5-wayland qt6-wayland waybar rofi-wayland swww \
    swaync hyprlock hypridle kitty wl-clipboard \
    brightnessctl playerctl pavucontrol thunar \
    ttf-jetbrains-mono-nerd papirus-icon-theme
```

### Step 2: Deploy Your Config (As Normal)

```bash
cd ~/Documents/hyprlandconfig
./deploy-configs.sh
```

### Step 3: Adjust Config (Remove AUR Dependencies)

Edit `~/.config/hypr/UserConfigs/Startup_Apps.conf`:

```bash
# Comment out quickshell (AUR package)
# exec-once = qs

# Or replace with AGS (in official repos)
sudo pacman -S ags
# Then uncomment:
# exec-once = ags
```

Edit `~/.config/hypr/UserConfigs/UserKeybinds.conf`:

```bash
# Comment out quickshell keybind
# bind = $mainMod, A, global, quickshell:overviewToggle
```

### Step 4: Configure Monitors Manually

Instead of `nwg-displays` (AUR), edit manually:

```bash
# List monitors
hyprctl monitors

# Edit config
nano ~/.config/hypr/monitors.conf

# Example:
# monitor=HDMI-A-1,1920x1080@60,0x0,1
```

---

## Recommendation

### For Full Experience (Recommended)
```bash
# Install yay (one-time, 5 minutes)
# Then install ALL packages from PACKAGES.md
```

### For Minimal/Stable Setup (Alternative)
```bash
# Use ONLY pacman
# Skip: quickshell-git, nwg-displays, wallust
# Configure monitors manually
# Use AGS instead of quickshell (or skip desktop overview)
```

---

## Summary

### AUR: Optional but Recommended
- **pacman has 90% of what you need**
- **AUR adds nice-to-have features** (desktop overview, GUI tools)
- **You can run Hyprland without AUR**, just with fewer features

### Hyprland-Specific Packages: Required
Even with GNOME installed, you need:
- `xdg-desktop-portal-hyprland` (different from GNOME's portal)
- `hyprland` (different compositor than mutter)
- `waybar`, `rofi-wayland`, `swww` (GNOME doesn't include these)

### Qt Wayland: Might Already Have
- Check with `pacman -Qi qt5-wayland qt6-wayland`
- If already installed by GNOME, skip
- If not, install them

---

## Quick Decision Tree

**Do you want the full config experience?**
- Yes → Install yay + all AUR packages
- No → Skip AUR, use pacman only

**Do you have GNOME installed?**
- Yes → Check for qt-wayland first, might already have it
- No (fresh install) → Install everything from PACKAGES.md

**Do you want to keep GDM?**
- Yes → Skip SDDM, use GDM to launch Hyprland
- No → Install SDDM and custom theme

---

**Bottom Line:**
- **90% of packages are in official repos (pacman)**
- **10% are in AUR** (desktop overview, GUI tools, color schemes)
- **You can skip AUR** and still have a working Hyprland setup
- **Hyprland needs its own portal** even if you have GNOME's
