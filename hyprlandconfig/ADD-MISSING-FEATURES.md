# Adding Missing Features Guide

You mentioned these features are missing:
1. ❌ **Brightness controls** in Waybar
2. ❌ **Display settings** GUI
3. ❌ **Custom login UI** (SDDM theme)

**Good news:** You already have all of these! They just need to be activated or extracted.

---

## Feature 1: Brightness Controls ☀️

### Current Status
- ✅ Brightness script exists: `~/.config/hypr/scripts/Brightness.sh`
- ✅ Brightness module exists in Waybar Modules file
- ❌ But it's NOT in your current active Waybar layout

### Why You Don't See It
Your active Waybar config is `[TOP] Default Laptop` which **doesn't include** the backlight module.

### Solution: Switch to a Waybar Layout with Brightness

**Option A: Switch to a Different Waybar Layout (Quick)**

```bash
# Use the Waybar style switcher (built into your config)
# Press: SUPER + CTRL + B
# This will show a Rofi menu with all available layouts
# Select: "[TOP] Default Laptop Custom"
```

This layout includes brightness controls on line 55.

**Option B: Add Brightness to Current Layout (Manual)**

Edit your current Waybar config:
```bash
nano ~/.config/waybar/configs/[TOP]\ Default\ Laptop
```

In the `"modules-right"` section, add `"backlight",` after battery:
```json
"modules-right": [
    "group/app_drawer",
    "custom/separator#blank",
    "group/notify",
    "custom/separator#blank",
    "tray",
    "custom/separator#blank",
    "custom/tty",
    "custom/updater",
    "group/laptop",
    "backlight",                    # ADD THIS LINE
    "custom/separator#blank",       # ADD THIS LINE
    "custom/separator#blank",
    "group/mobo_drawer",
    "custom/separator#blank",
    "group/audio",
    "custom/separator#blank",
    "group/status",
],
```

Then restart Waybar:
```bash
pkill waybar && waybar &
```

### How Brightness Controls Work

Once activated, you can:
- **Scroll on the brightness icon** to adjust (defined in Waybar Modules)
- **Click** to open brightness settings (if configured)
- Uses `brightnessctl` in the background
- Shows notifications with current brightness level

The brightness script is at: `~/.config/hypr/scripts/Brightness.sh`

It uses:
- `brightnessctl` to control backlight
- `swaync` for notifications
- Adjusts in 10% increments
- Min brightness: 5%, Max: 100%

---

## Feature 2: Display Settings GUI 🖥️

### Current Status
- ✅ `nwg-displays` is already documented in your package list
- ✅ Monitor configuration exists in `monitors.conf`

### How to Use

**Option A: GUI Tool (nwg-displays)**

Install if not already:
```bash
yay -S nwg-displays
```

Launch:
```bash
nwg-displays
```

Features:
- Drag and drop monitor arrangement
- Set resolution, refresh rate, scaling
- Rotate displays
- Set primary monitor
- Saves to `~/.config/hypr/monitors.conf` automatically

**Option B: Manual Configuration**

Edit monitor config directly:
```bash
nano ~/.config/hypr/monitors.conf
```

Current config (from your system):
```conf
monitor=desc:Japan Display Inc. 0x422A,3000x2000@60.0,3549x1384,2.0
monitor=desc:Dell Inc. DELL S2721HN JD6PSJ3,1920x1080@74.97,3549x304,1.0
monitor=desc:Dell Inc. DELL S2425H 82M1G34,1280x1024@75.03,2525x756,1.0
monitor=desc:Dell Inc. DELL S2425H 82M1G34,transform,3
```

Format:
```
monitor=NAME,WIDTHxHEIGHT@REFRESH,POSITION_X,POSITION_Y,SCALE
```

To list available monitors:
```bash
hyprctl monitors
```

Reload after editing:
```bash
hyprctl reload
```

### Add Keybinding for Display Settings (Optional)

Add to `~/.config/hypr/UserConfigs/UserKeybinds.conf`:
```conf
bind = $mainMod SHIFT, M, exec, nwg-displays  # Open monitor settings
```

---

## Feature 3: Custom Login UI (SDDM Theme) 🎨

### Current Status
- ✅ SDDM is installed and enabled
- ✅ Custom theme "simple-sddm-2" is already configured
- ❌ Theme files not extracted to your backup folder yet

### Extract SDDM Theme

Run this to copy your SDDM theme to the backup:

```bash
# Create SDDM directory in backup
mkdir -p ~/Documents/hyprlandconfig/sddm

# Copy SDDM config
sudo cp /etc/sddm.conf ~/Documents/hyprlandconfig/sddm/sddm.conf
sudo chown $USER:$USER ~/Documents/hyprlandconfig/sddm/sddm.conf

# Copy the theme
sudo cp -r /usr/share/sddm/themes/simple-sddm-2 ~/Documents/hyprlandconfig/sddm/
sudo chown -R $USER:$USER ~/Documents/hyprlandconfig/sddm/simple-sddm-2

echo "SDDM theme extracted!"
```

### Deploy SDDM on Fresh Install

On a new Arch system:

1. **Install SDDM**
```bash
sudo pacman -S sddm qt5-virtualkeyboard qt5-graphicaleffects qt5-quickcontrols2 qt5-svg
```

2. **Copy Theme**
```bash
# Copy your custom theme
sudo cp -r ~/Documents/hyprlandconfig/sddm/simple-sddm-2 /usr/share/sddm/themes/

# Copy SDDM config
sudo cp ~/Documents/hyprlandconfig/sddm/sddm.conf /etc/sddm.conf
```

3. **Enable SDDM**
```bash
sudo systemctl enable sddm
sudo systemctl start sddm
```

4. **Reboot**
```bash
reboot
```

You should see the custom login screen instead of basic TTY.

### Customize SDDM Theme (Optional)

Edit theme files:
```bash
sudo nano /usr/share/sddm/themes/simple-sddm-2/theme.conf
```

Change:
- Background image
- Colors
- Font
- User avatar

### Alternative: Install Other SDDM Themes

Popular themes:
```bash
# Catppuccin theme
yay -S sddm-catppuccin-git

# Sugar Candy theme
yay -S sddm-sugar-candy-git

# Corners theme
yay -S sddm-theme-corners-git
```

Then edit `/etc/sddm.conf`:
```conf
[Theme]
Current=sddm-catppuccin-mocha  # or your chosen theme
```

### View SDDM Theme Preview (Without Rebooting)

```bash
sddm-greeter --test-mode --theme /usr/share/sddm/themes/simple-sddm-2
```

---

## Complete Extraction Script

Update your extraction script to include SDDM:

```bash
nano ~/Documents/hyprlandconfig/extract-configs.sh
```

Add this section before the final echo:

```bash
# Extract SDDM theme
echo "Extracting SDDM login theme..."
mkdir -p "$CONFIG_DIR/sddm"
sudo cp /etc/sddm.conf "$CONFIG_DIR/sddm/sddm.conf" 2>/dev/null
sudo cp -r /usr/share/sddm/themes/simple-sddm-2 "$CONFIG_DIR/sddm/" 2>/dev/null
sudo chown -R $USER:$USER "$CONFIG_DIR/sddm/" 2>/dev/null
```

Then re-run:
```bash
cd ~/Documents/hyprlandconfig
./extract-configs.sh
```

---

## Summary: What You Already Have

| Feature | Status | Location |
|---------|--------|----------|
| **Brightness controls** | ✅ Installed | `~/.config/hypr/scripts/Brightness.sh` |
| **Brightness in Waybar** | ⚠️ Inactive | Available in other Waybar layouts |
| **Display settings GUI** | ✅ Available | `nwg-displays` (needs install) |
| **Custom login (SDDM)** | ✅ Active | `/etc/sddm.conf` + theme |
| **Brightness script** | ✅ Working | Uses `brightnessctl` |

---

## Quick Activation Checklist

To activate all features RIGHT NOW on your current system:

1. **Brightness in Waybar**
   ```bash
   # Press SUPER + CTRL + B
   # Select: [TOP] Default Laptop Custom
   ```

2. **Display Settings**
   ```bash
   yay -S nwg-displays
   nwg-displays
   ```

3. **Extract SDDM Theme**
   ```bash
   mkdir -p ~/Documents/hyprlandconfig/sddm
   sudo cp /etc/sddm.conf ~/Documents/hyprlandconfig/sddm/
   sudo cp -r /usr/share/sddm/themes/simple-sddm-2 ~/Documents/hyprlandconfig/sddm/
   sudo chown -R $USER:$USER ~/Documents/hyprlandconfig/sddm/
   ```

---

## Available Waybar Layouts (With Brightness)

Your system has these layouts with brightness controls:

1. **[TOP] Default Laptop Custom** - ✅ Has backlight (line 55)
2. **[TOP & BOT] SummitSplit** - ✅ Has backlight
3. **[TOP] Minimal.jsonc** - ✅ Has backlight

To see all available layouts:
```bash
ls ~/.config/waybar/configs/
```

To switch layouts:
- **Via keybind:** `SUPER + ALT + B` (Waybar Layout Menu)
- **Via script:** `~/.config/hypr/scripts/WaybarLayout.sh`

---

## Deploy on Fresh Arch Install

Update your `deploy-configs.sh` to include SDDM:

Add after the Neovim section:

```bash
# Deploy SDDM theme
echo ""
echo "Step 7: Deploying SDDM login theme..."
if [ -d "$CONFIG_SOURCE/sddm" ]; then
    sudo mkdir -p /usr/share/sddm/themes
    sudo cp -r "$CONFIG_SOURCE/sddm/simple-sddm-2" /usr/share/sddm/themes/ 2>/dev/null
    sudo cp "$CONFIG_SOURCE/sddm/sddm.conf" /etc/sddm.conf 2>/dev/null
    sudo systemctl enable sddm
    echo "SDDM theme deployed. Will be active after reboot."
else
    echo "Info: SDDM theme not found in backup"
fi
```

---

## Brightness Keybindings (Already Configured)

These work once brightness is in Waybar:

- **Scroll up** on brightness icon → Increase
- **Scroll down** on brightness icon → Decrease

Or add keyboard shortcuts to `UserKeybinds.conf`:
```conf
# Brightness controls
bind = , XF86MonBrightnessUp, exec, $scriptsDir/Brightness.sh --inc
bind = , XF86MonBrightnessDown, exec, $scriptsDir/Brightness.sh --dec

# Manual controls (if laptop keys don't work)
bind = $mainMod, F2, exec, $scriptsDir/Brightness.sh --dec
bind = $mainMod, F3, exec, $scriptsDir/Brightness.sh --inc
```

---

## Troubleshooting

### Brightness Controls Not Working

```bash
# Check if brightnessctl is installed
pacman -Qi brightnessctl

# Install if missing
sudo pacman -S brightnessctl

# Check available devices
brightnessctl --list

# Test manually
brightnessctl set 50%
```

### SDDM Not Showing Custom Theme

```bash
# Check SDDM config
cat /etc/sddm.conf

# Should show:
# [Theme]
# Current=simple-sddm-2

# Check theme exists
ls /usr/share/sddm/themes/simple-sddm-2

# Restart SDDM
sudo systemctl restart sddm
```

### nwg-displays Not Working

```bash
# Install dependencies
sudo pacman -S python-gobject gtk3 gtk-layer-shell

# Reinstall
yay -S nwg-displays

# Run from terminal to see errors
nwg-displays
```

---

## Next Steps

1. Extract SDDM theme now (run the extraction commands above)
2. Update your extraction script to include SDDM
3. Update your deployment script to deploy SDDM
4. Test Waybar layout switching to see brightness controls
5. Install nwg-displays for GUI monitor configuration

All three features are available - they just need to be extracted and documented!
