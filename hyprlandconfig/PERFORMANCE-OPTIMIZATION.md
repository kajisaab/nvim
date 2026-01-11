# Performance Optimization Guide

Analysis of package weights and performance impact in your HyprFlux/Hyprland setup.

---

## Package Weight Analysis

### ⚠️ HEAVY Packages (Could Slow Down System)

| Package | RAM Usage | CPU Usage | Disk Size | Impact | Can You Skip? |
|---------|-----------|-----------|-----------|--------|---------------|
| **Electron Apps** | 200-500MB each | Medium | 200-500MB | 🔴 HIGH | ✅ Yes - don't install them |
| - VS Code | ~300MB | Medium | ~400MB | 🔴 HIGH | Use Neovim instead |
| - Discord/Vesktop | ~200MB | Medium | ~300MB | 🔴 HIGH | Use lightweight client |
| - Obsidian | ~250MB | Medium | ~350MB | 🔴 HIGH | Use terminal notes |
| **Firefox** | 300-800MB | Medium-High | ~250MB | 🟡 MEDIUM | Use lighter browser |
| **GNOME (if installed)** | 400-600MB | Medium | ~2GB | 🔴 HIGH | Uninstall if only using Hyprland |
| **Blueman** | ~50MB | Low | ~5MB | 🟢 LOW | Keep if you use Bluetooth |
| **Thunar + dependencies** | ~100MB | Low | ~50MB | 🟢 LOW | Can use `lf` or `ranger` |

### ✅ LIGHTWEIGHT Core Components (Keep These)

| Package | RAM Usage | CPU Usage | Disk Size | Impact |
|---------|-----------|-----------|-----------|--------|
| **Hyprland** | ~50-100MB | Low-Medium | ~15MB | 🟢 Very efficient |
| **Waybar** | ~30-50MB | Very Low | ~5MB | 🟢 Lightweight |
| **Kitty** | ~30-50MB | Low | ~15MB | 🟢 Lightweight |
| **Rofi** | ~20MB (when open) | Very Low | ~3MB | 🟢 Very light |
| **SWWW** | ~20-40MB | Very Low | ~3MB | 🟢 Lightweight |
| **Neovim** | ~20-40MB | Low | ~30MB | 🟢 Lightweight |
| **swaync** | ~30MB | Very Low | ~5MB | 🟢 Lightweight |

### 🔄 BACKGROUND Processes (Always Running)

| Process | RAM Usage | CPU Impact | Can Disable? |
|---------|-----------|------------|--------------|
| `hyprland` | ~50-100MB | Low (uses GPU) | ❌ No - it's the compositor |
| `waybar` | ~30-50MB | Very Low | ⚠️ Yes, but you lose status bar |
| `swww-daemon` | ~20-40MB | Very Low | ✅ Yes - if you don't need wallpapers |
| `swaync` | ~30MB | Very Low | ✅ Yes - use dunst instead |
| `nm-applet` | ~20MB | Very Low | ⚠️ Keep for WiFi management |
| `blueman-applet` | ~50MB | Low | ✅ Yes - only if you use Bluetooth |
| `wl-paste` (2 instances) | ~10MB each | Very Low | ⚠️ Keep for clipboard history |
| `quickshell (qs)` | ~80-150MB | Medium | ✅ Yes - desktop overview only |
| `pipewire` | ~30-50MB | Low | ❌ No - needed for audio |
| `wireplumber` | ~20MB | Very Low | ❌ No - needed for audio |

---

## Total RAM Usage Breakdown

### Minimal Hyprland Setup (Fresh Boot)
```
Hyprland compositor:      ~70MB
Waybar:                   ~40MB
SWWW daemon:              ~25MB
swaync:                   ~30MB
NetworkManager applet:    ~20MB
Clipboard (wl-paste x2):  ~20MB
PipeWire + WirePlumber:   ~70MB
----------------------------------
TOTAL BASE:              ~275MB
```

### Your Full Config (With All Features)
```
Base components:         ~275MB
Quickshell (qs):         ~120MB
Blueman:                  ~50MB
Wallpaper auto-changer:   ~10MB
----------------------------------
TOTAL:                   ~455MB
```

### If You Also Run Electron Apps
```
Base Hyprland:           ~455MB
VS Code:                 ~300MB
Firefox (3-4 tabs):      ~400MB
Discord/Vesktop:         ~200MB
Obsidian:                ~250MB
----------------------------------
TOTAL:                  ~1605MB (1.6GB)
```

---

## What's Slowing You Down? (Diagnosis)

### Check Current RAM Usage

```bash
# See total RAM usage
free -h

# See what's using RAM right now
ps aux --sort=-%mem | head -20

# See Hyprland-specific processes
ps aux | grep -E "hypr|waybar|swww|swaync|quickshell"
```

### Check CPU Usage

```bash
# Real-time process monitor
htop

# Or simpler:
top

# Check Hyprland CPU usage specifically
ps aux --sort=-%cpu | head -20
```

### Check Startup Time

```bash
# See how long boot takes
systemd-analyze

# See what's slow at startup
systemd-analyze blame
```

---

## Performance Optimization Strategies

### Strategy 1: Remove Heavy Electron Apps ⚡ (Save ~1GB RAM)

**Don't install these in your config:**

```bash
# SKIP these heavy apps from UserKeybinds.conf:
# bind = $mainMod, C, exec, code                    # VS Code (300MB)
# bind = $mainMod, O, exec, obsidian                # Obsidian (250MB)
# bind = $mainMod, X, exec, vesktop                 # Discord (200MB)
```

**Lightweight alternatives:**

| Heavy App | RAM | Lightweight Alternative | RAM Saved |
|-----------|-----|-------------------------|-----------|
| VS Code (300MB) | 300MB | Neovim | ~280MB |
| Obsidian (250MB) | 250MB | Neovim + Markdown | ~230MB |
| Discord (200MB) | 200MB | Cordless (terminal) | ~180MB |
| Firefox (400MB) | 400MB | qutebrowser or Links2 | ~350MB |
| Thunar (100MB) | 100MB | lf or ranger (terminal) | ~80MB |

### Strategy 2: Disable Unused Background Services ⚡ (Save ~200MB)

Edit `~/.config/hypr/UserConfigs/Startup_Apps.conf`:

```bash
# DISABLE quickshell (desktop overview) - saves ~120MB
# exec-once = qs

# DISABLE blueman if you don't use Bluetooth - saves ~50MB
# exec-once = blueman-applet

# DISABLE wallpaper auto-changer - saves ~10-30MB
# exec-once = $SwwwRandom $wallDIR

# REPLACE swaync with dunst (lighter) - saves ~10MB
# exec-once = swaync
exec-once = dunst  # Install: sudo pacman -S dunst
```

### Strategy 3: Use Lighter Waybar Config ⚡ (Save ~10-20MB)

Switch to simpler Waybar layout:

```bash
# Use minimal layout
ln -sf ~/.config/waybar/configs/[TOP]\ Simpliest ~/.config/waybar/config
pkill waybar && waybar &
```

Simpler layouts:
- `[TOP] Simpliest` - Minimal modules (~20MB)
- `[TOP] Simple` - Few modules (~25MB)
- `[TOP] Default Laptop Custom` - Full featured (~40MB)

### Strategy 4: Disable Animations ⚡ (Better CPU Performance)

Edit `~/.config/hypr/UserConfigs/UserAnimations.conf`:

```bash
# Disable all animations
animations {
    enabled = no
}
```

Or reduce animation intensity:
```bash
# Lighter animations
animation = windows, 1, 2, default
animation = windowsOut, 1, 2, default
animation = border, 1, 5, default
animation = fade, 1, 5, default
animation = workspaces, 1, 3, default
```

### Strategy 5: Optimize Hyprland Settings ⚡ (Better Performance)

Edit `~/.config/hypr/UserConfigs/UserSettings.conf`:

```bash
# Reduce blur (CPU intensive)
decoration {
    blur {
        enabled = no  # Or reduce blur_passes to 1
    }
}

# Disable shadows
decoration {
    drop_shadow = no
}

# Reduce decoration overhead
decoration {
    rounding = 0  # No rounded corners
}

# VRR (Variable Refresh Rate) for better performance
misc {
    vrr = 1  # If your monitor supports it
}
```

### Strategy 6: Uninstall GNOME ⚡ (Save ~500MB + 2GB disk)

If you're ONLY using Hyprland and never boot into GNOME:

```bash
# Remove GNOME (DANGEROUS - make sure Hyprland works first!)
sudo pacman -Rns gnome gnome-extra

# Keep GDM if you want graphical login:
sudo pacman -S gdm  # Reinstall just GDM

# Or switch to lighter login manager:
sudo systemctl disable gdm
sudo pacman -S ly  # Lightweight TUI login manager
sudo systemctl enable ly
```

⚠️ **WARNING:** Only do this after confirming Hyprland works perfectly!

### Strategy 7: Use Lighter Terminal ⚡ (Save ~10-20MB per instance)

Replace Kitty with lighter alternatives:

| Terminal | RAM per Instance | Speed |
|----------|------------------|-------|
| Kitty | ~40MB | Fast (GPU accelerated) |
| Foot | ~20MB | Very Fast |
| Alacritty | ~30MB | Fast (GPU accelerated) |
| st (simple terminal) | ~10MB | Fastest |

Edit `~/.config/hypr/UserConfigs/01-UserDefaults.conf`:
```bash
$term = foot  # Instead of kitty
```

Install foot:
```bash
sudo pacman -S foot
```

---

## Recommended Optimization Levels

### Level 1: Light Optimization (Save ~200MB RAM)
```bash
# 1. Don't install Electron apps
# 2. Disable quickshell (desktop overview)
# 3. Disable blueman if no Bluetooth
# 4. Use foot instead of kitty
```

**Difficulty:** Easy
**RAM Saved:** ~200MB
**Impact:** Minimal feature loss

### Level 2: Medium Optimization (Save ~400MB RAM)
```bash
# Everything from Level 1, plus:
# 5. Use simple Waybar layout
# 6. Disable wallpaper auto-changer
# 7. Replace swaync with dunst
# 8. Reduce animations
```

**Difficulty:** Medium
**RAM Saved:** ~400MB
**Impact:** Some features gone

### Level 3: Extreme Optimization (Save ~1GB+ RAM)
```bash
# Everything from Level 1-2, plus:
# 9. Disable blur and shadows
# 10. No rounded corners
# 11. Disable animations completely
# 12. Use terminal file manager (lf/ranger)
# 13. Uninstall GNOME completely
# 14. Use qutebrowser instead of Firefox
```

**Difficulty:** Hard
**RAM Saved:** ~1GB+
**Impact:** Minimal desktop features

---

## What You Should Actually Do

### If You Have 8GB RAM or More
**Keep everything as-is.** Your config is already efficient.

- Hyprland is lightweight (~455MB base)
- Just avoid installing too many Electron apps
- You're fine!

### If You Have 4GB RAM
**Apply Level 1 optimizations:**

```bash
# 1. Skip Electron apps (VS Code, Discord, Obsidian)
# 2. Use Neovim instead of VS Code
# 3. Disable quickshell
# 4. Use foot terminal
```

Edit `Startup_Apps.conf`:
```bash
# Comment out:
# exec-once = qs
```

Edit `01-UserDefaults.conf`:
```bash
$term = foot
```

### If You Have 2GB RAM (Very Low)
**Apply Level 3 optimizations:**

- Use Hyprland without GNOME
- Disable all animations
- Disable blur/shadows
- Use terminal-based apps only
- Consider using a lighter WM (dwl, sway)

---

## Performance Comparison

### Heavy Desktop Environments
```
GNOME:         ~600-800MB RAM
KDE Plasma:    ~500-700MB RAM
Cinnamon:      ~500-600MB RAM
```

### Lightweight DEs
```
XFCE:          ~300-400MB RAM
LXQt:          ~250-350MB RAM
```

### Tiling WMs (like Hyprland)
```
Hyprland:      ~275-455MB RAM (your config)
Sway:          ~200-300MB RAM
i3:            ~150-200MB RAM (X11 only)
dwl:           ~100-150MB RAM
```

**Your Hyprland setup is already in the "lightweight" category!**

---

## Check Your System Specs

```bash
# Check RAM
free -h

# Check CPU
lscpu | grep "Model name"

# Check if you have swap
swapon --show

# Check disk usage
df -h
```

---

## Quick Optimization Script

Save this as `~/Documents/hyprlandconfig/optimize-performance.sh`:

```bash
#!/bin/bash
# Quick performance optimization for Hyprland

echo "=== Hyprland Performance Optimizer ==="
echo ""

# Show current RAM usage
echo "Current RAM usage:"
free -h | grep Mem
echo ""

# Backup configs
echo "Creating backup..."
cp ~/.config/hypr/UserConfigs/Startup_Apps.conf ~/.config/hypr/UserConfigs/Startup_Apps.conf.bak

# Disable quickshell
echo "Disabling quickshell (desktop overview)..."
sed -i 's/^exec-once = qs/#exec-once = qs/' ~/.config/hypr/UserConfigs/Startup_Apps.conf

# Disable wallpaper auto-changer
echo "Disabling wallpaper auto-changer..."
sed -i 's/^exec-once = \$SwwwRandom/#exec-once = \$SwwwRandom/' ~/.config/hypr/UserConfigs/Startup_Apps.conf

# Disable blueman (if you don't use Bluetooth)
read -p "Do you use Bluetooth? (y/n): " bluetooth
if [ "$bluetooth" != "y" ]; then
    sed -i 's/^exec-once = blueman-applet/#exec-once = blueman-applet/' ~/.config/hypr/UserConfigs/Startup_Apps.conf
fi

echo ""
echo "Optimizations applied! Reload Hyprland to see effects."
echo "To revert: cp ~/.config/hypr/UserConfigs/Startup_Apps.conf.bak ~/.config/hypr/UserConfigs/Startup_Apps.conf"
```

---

## Bottom Line

### Your Config is Already Lightweight! ✅

**Base Hyprland:** ~275MB (very good!)
**With all features:** ~455MB (still good!)

### Biggest RAM Hogs (Not in Core Config)
1. **Electron Apps** (VS Code, Discord, Obsidian) - 200-500MB each
2. **GNOME** (if installed alongside) - 500MB+
3. **Firefox** with many tabs - 400MB+

### Safest Optimizations (No Feature Loss)
1. Don't install Electron apps → Use Neovim
2. Use foot instead of kitty → Save 20MB per terminal
3. Disable quickshell if you don't use desktop overview → Save 120MB

**Your Hyprland config is actually very efficient compared to GNOME/KDE!**

---

## Monitor Performance After Install

```bash
# Install htop for monitoring
sudo pacman -S htop

# Run it
htop

# Watch RAM usage over time
watch -n 5 free -h
```

If RAM usage is high, check what's running:
```bash
ps aux --sort=-%mem | head -20
```

Most likely culprits: Electron apps (VS Code, Discord), not Hyprland itself.
