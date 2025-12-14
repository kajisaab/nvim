# Rofi Application Launcher Setup Guide

Complete setup guide for Rofi - a modern, fast, and highly customizable application launcher for Linux.

---

## Table of Contents

1. [What is Rofi?](#what-is-rofi)
2. [Features](#features)
3. [Installation](#installation)
4. [Configuration Files](#configuration-files)
5. [Keybinding Setup](#keybinding-setup)
6. [Usage & Modes](#usage--modes)
7. [Customization](#customization)
8. [Troubleshooting](#troubleshooting)

---

## What is Rofi?

Rofi is a window switcher, application launcher, and dmenu replacement that provides:
- **Application Launcher**: Search and launch applications
- **Window Switcher**: Switch between open windows
- **Run Dialog**: Execute shell commands
- **File Browser**: Browse and open files
- **SSH Launcher**: Quick SSH connections
- **Custom Scripts**: Extensible with custom modes

**Why Rofi over default launchers?**
- Fast and lightweight
- Fuzzy search with FZF-style matching
- Keyboard-driven workflow
- Highly customizable appearance
- Multiple modes in one tool
- Works with any desktop environment or window manager

---

## Features

### Current Configuration Features

✅ **Multiple Modes:**
- Application launcher (drun)
- Command runner (run)
- Window switcher (window)
- SSH launcher
- File browser

✅ **Modern UI:**
- Catppuccin-inspired color scheme
- Rounded corners and borders
- Icon support for applications
- Smooth animations

✅ **Smart Search:**
- Fuzzy matching (FZF algorithm)
- Case-insensitive search
- Searches across app names, descriptions, categories

✅ **Keyboard Navigation:**
- Vim-style navigation (Ctrl+j/k)
- Tab between modes
- Quick accept with Enter

✅ **Performance:**
- Fast startup time
- Efficient memory usage
- Instant search results

---

## Installation

### Step 1: Install Rofi

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install rofi

# Verify installation
rofi -version
```

**Expected Output:**
```
Version: 1.7.5
```

### Step 2: Create Configuration Directory

```bash
# Create rofi config directory
mkdir -p ~/.config/rofi

# Verify
ls -la ~/.config/rofi
```

### Step 3: Create Configuration Files

#### 3.1 Create Main Config File

Create `~/.config/rofi/config.rasi`:

```bash
nvim ~/.config/rofi/config.rasi
```

Paste the following configuration:

```rasi
configuration {
    modi: "drun,run,window,ssh,filebrowser";
    show-icons: true;
    terminal: "gnome-terminal";
    drun-display-format: "{name}";
    display-drun: "  Apps";
    display-run: "  Run";
    display-window: " 﩯 Windows";
    display-filebrowser: "  Files";
    display-ssh: "  SSH";
    sidebar-mode: true;

    font: "JetBrains Mono 12";

    kb-mode-next: "Alt+Tab";
    kb-mode-previous: "Alt+Shift+Tab";
    kb-row-up: "Up,Control+k";
    kb-row-down: "Down,Control+j";
    kb-accept-entry: "Return,KP_Enter";
    kb-remove-to-eol: "Control+Shift+e";
    kb-cancel: "Escape,Control+c";

    matching: "fuzzy";
    sort: true;
    sorting-method: "fzf";
    case-sensitive: false;

    timeout {
        action: "kb-cancel";
        delay: 0;
    }
}

* {
    bg: #1e1e2e;
    bg-alt: #181825;
    fg: #cdd6f4;
    fg-alt: #bac2de;

    background-color: transparent;
    text-color: @fg;

    accent: #89b4fa;
    accent-alt: #74c7ec;
    urgent: #f38ba8;
    selected: #313244;
}

window {
    transparency: "real";
    background-color: @bg;
    border: 2px;
    border-color: @accent;
    border-radius: 12px;
    width: 45%;
    height: 55%;
    padding: 0px;
    location: center;
    anchor: center;
}

mainbox {
    background-color: @bg;
    children: [ inputbar, mode-switcher, listview ];
    spacing: 10px;
    padding: 20px;
    border-radius: 12px;
}

inputbar {
    background-color: @bg-alt;
    text-color: @fg;
    border-radius: 8px;
    padding: 12px 16px;
    children: [ prompt, entry ];
    spacing: 10px;
}

prompt {
    background-color: transparent;
    text-color: @accent;
    font: "JetBrains Mono Bold 13";
}

entry {
    background-color: transparent;
    text-color: @fg;
    placeholder: "Search...";
    placeholder-color: @fg-alt;
    cursor: text;
}

mode-switcher {
    background-color: @bg-alt;
    border-radius: 8px;
    padding: 8px;
    spacing: 8px;
}

button {
    background-color: transparent;
    text-color: @fg-alt;
    padding: 8px 12px;
    border-radius: 6px;
}

button selected {
    background-color: @accent;
    text-color: @bg;
    font: "JetBrains Mono Bold 11";
}

listview {
    background-color: transparent;
    columns: 1;
    lines: 10;
    spacing: 4px;
    cycle: false;
    dynamic: true;
    layout: vertical;
    scrollbar: false;
}

element {
    background-color: transparent;
    text-color: @fg;
    orientation: horizontal;
    border-radius: 8px;
    padding: 10px 12px;
    spacing: 10px;
}

element normal.normal {
    background-color: transparent;
    text-color: @fg;
}

element selected.normal {
    background-color: @selected;
    text-color: @accent;
    border: 1px;
    border-color: @accent;
}

element-icon {
    background-color: transparent;
    size: 32px;
    cursor: pointer;
}

element-text {
    background-color: transparent;
    text-color: inherit;
    cursor: pointer;
    vertical-align: 0.5;
}

message {
    background-color: @bg-alt;
    border-radius: 8px;
    padding: 12px;
}

textbox {
    background-color: transparent;
    text-color: @fg;
}
```

#### 3.2 Create Launcher Script

Create `~/.config/rofi/launcher.sh`:

```bash
nvim ~/.config/rofi/launcher.sh
```

Paste the following:

```bash
#!/bin/bash

rofi -show drun \
    -theme ~/.config/rofi/config.rasi \
    -show-icons \
    -drun-match-fields name,generic,exec,categories,keywords \
    -drun-show-actions
```

Make it executable:

```bash
chmod +x ~/.config/rofi/launcher.sh
```

### Step 4: Test Rofi

```bash
# Test the launcher script
~/.config/rofi/launcher.sh

# Or test directly
rofi -show drun
```

You should see the Rofi launcher appear in the center of your screen.

---

## Keybinding Setup

Set up `Alt+Space` to trigger Rofi launcher.

### GNOME Desktop

#### Method 1: Using Settings GUI

1. Open **Settings**
2. Navigate to **Keyboard** → **Keyboard Shortcuts** → **Custom Shortcuts**
3. Click **Add Shortcut** (or `+` button)
4. Fill in:
   - **Name**: `Rofi Launcher`
   - **Command**: `/home/amankhadka/.config/rofi/launcher.sh`
   - **Shortcut**: Press `Alt+Space`

#### Method 2: Using gsettings (Command Line)

```bash
# First, disable the default Alt+Space (overlay key)
gsettings set org.gnome.desktop.wm.keybindings panel-main-menu "[]"

# Add custom keybinding
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Rofi Launcher'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command '/home/amankhadka/.config/rofi/launcher.sh'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Alt>space'
```

#### Verify GNOME Keybinding

```bash
# Check if Alt+Space is assigned
gsettings get org.gnome.desktop.wm.keybindings panel-main-menu

# Should show: @as []

# Check custom keybinding
gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings

# Should show: ['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']
```

### KDE Plasma

1. Open **System Settings**
2. Navigate to **Shortcuts** → **Custom Shortcuts**
3. Click **Edit** → **New** → **Global Shortcut** → **Command/URL**
4. **Trigger** tab: Set to `Alt+Space`
5. **Action** tab: Enter `/home/amankhadka/.config/rofi/launcher.sh`
6. Apply

### i3 Window Manager

Add to `~/.config/i3/config`:

```bash
# Rofi launcher
bindsym Mod1+space exec --no-startup-id ~/.config/rofi/launcher.sh
```

Reload i3:
```bash
i3-msg reload
```

### Xfce

1. Open **Settings Manager**
2. Go to **Keyboard** → **Application Shortcuts**
3. Click **Add**
4. Command: `/home/amankhadka/.config/rofi/launcher.sh`
5. Press `Alt+Space` when prompted

### Openbox

Add to `~/.config/openbox/rc.xml` in the `<keyboard>` section:

```xml
<keybind key="A-space">
  <action name="Execute">
    <command>/home/amankhadka/.config/rofi/launcher.sh</command>
  </action>
</keybind>
```

Reconfigure Openbox:
```bash
openbox --reconfigure
```

---

## Usage & Modes

### Launching Rofi

Press `Alt+Space` to open Rofi launcher.

### Available Modes

Rofi has 5 modes accessible via tabs at the top:

#### 1. Apps (drun) - Default Mode
**Icon**:
**Purpose**: Launch desktop applications

**Usage:**
- Type to search for applications
- Press `Enter` to launch
- Fuzzy matching: Type "chro" to find "Chrome"

**Examples:**
- Type "fire" → Firefox
- Type "code" → VS Code
- Type "term" → Terminal

#### 2. Run (run)
**Icon**:
**Purpose**: Execute shell commands

**Usage:**
- Type any shell command
- Press `Enter` to execute
- Command history is saved

**Examples:**
- `htop` → Open system monitor
- `firefox google.com` → Open Firefox with URL
- `gnome-control-center` → Open settings

#### 3. Windows (window)
**Icon**: 﩯
**Purpose**: Switch between open windows

**Usage:**
- Shows all open windows across workspaces
- Type to filter by window title
- Press `Enter` to switch to window

**Examples:**
- Type "fire" → Switch to Firefox window
- Type "nvim" → Switch to Neovim window

#### 4. Files (filebrowser)
**Icon**:
**Purpose**: Browse and open files

**Usage:**
- Navigate file system
- Type to filter files
- Press `Enter` to open with default app

**Examples:**
- Navigate to Documents folder
- Search for specific file
- Open with default application

#### 5. SSH (ssh)
**Icon**:
**Purpose**: Quick SSH connections

**Usage:**
- Lists SSH hosts from `~/.ssh/config`
- Type to filter hosts
- Press `Enter` to connect

**Setup:**
Create `~/.ssh/config`:
```
Host myserver
    HostName 192.168.1.100
    User ubuntu
    Port 22

Host github
    HostName github.com
    User git
```

---

## Keyboard Shortcuts

### Navigation

| Shortcut | Action |
|----------|--------|
| `Alt+Space` | Open Rofi launcher |
| `Escape` / `Ctrl+c` | Close Rofi |
| `↑` / `Ctrl+k` | Move up in list |
| `↓` / `Ctrl+j` | Move down in list |
| `Enter` | Select/Launch item |
| `Alt+Tab` | Switch to next mode |
| `Alt+Shift+Tab` | Switch to previous mode |

### Editing

| Shortcut | Action |
|----------|--------|
| `Ctrl+w` | Delete word backward |
| `Ctrl+u` | Delete to beginning of line |
| `Ctrl+Shift+e` | Delete to end of line |
| `Home` | Move to beginning |
| `End` | Move to end |

### Advanced

| Shortcut | Action |
|----------|--------|
| `Ctrl+Space` | Switch between modes |
| `Shift+Enter` | Launch in terminal (for apps) |
| `Ctrl+Enter` | Custom action (app-specific) |

---

## Configuration Explained

### Main Configuration Options

**File Location**: `~/.config/rofi/config.rasi`

#### Modes Configuration
```rasi
modi: "drun,run,window,ssh,filebrowser";
```
- Defines available modes
- Order determines display order

#### Display Options
```rasi
show-icons: true;              // Show application icons
terminal: "gnome-terminal";    // Terminal for commands
font: "JetBrains Mono 12";     // Font and size
```

#### Search Configuration
```rasi
matching: "fuzzy";             // Fuzzy search like FZF
sorting-method: "fzf";         // FZF-style sorting
case-sensitive: false;         // Ignore case in search
```

#### Window Appearance
```rasi
width: 45%;                    // Window width (% of screen)
height: 55%;                   // Window height
location: center;              // Position on screen
border-radius: 12px;           // Rounded corners
```

### Color Scheme (Catppuccin-inspired)

```rasi
bg: #1e1e2e;          // Main background
bg-alt: #181825;      // Alternative background
fg: #cdd6f4;          // Foreground text
accent: #89b4fa;      // Accent color (blue)
selected: #313244;    // Selected item background
urgent: #f38ba8;      // Urgent/error color
```

---

## Customization

### Change Font

Edit `~/.config/rofi/config.rasi`:
```rasi
font: "Your Font Name 14";
```

**Popular Fonts:**
- `"JetBrains Mono 12"`
- `"FiraCode Nerd Font 11"`
- `"Ubuntu Mono 13"`
- `"Hack 12"`

### Change Window Size

```rasi
window {
    width: 50%;     // Make wider (default: 45%)
    height: 60%;    // Make taller (default: 55%)
}
```

### Change Position

```rasi
window {
    location: north;    // Options: north, south, east, west,
                       //          center, northwest, northeast,
                       //          southwest, southeast
}
```

### Disable Icons

```rasi
configuration {
    show-icons: false;
}
```

### Change Number of Visible Items

```rasi
listview {
    lines: 15;     // Show 15 items (default: 10)
}
```

### Add/Remove Modes

```rasi
configuration {
    modi: "drun,window";  // Only apps and windows
}
```

### Custom Color Scheme

Replace the color variables with your own:

**Tokyo Night:**
```rasi
* {
    bg: #1a1b26;
    fg: #c0caf5;
    accent: #7aa2f7;
    selected: #24283b;
}
```

**Dracula:**
```rasi
* {
    bg: #282a36;
    fg: #f8f8f2;
    accent: #bd93f9;
    selected: #44475a;
}
```

**Gruvbox:**
```rasi
* {
    bg: #282828;
    fg: #ebdbb2;
    accent: #fabd2f;
    selected: #3c3836;
}
```

### Change Terminal

If you use a different terminal:
```rasi
configuration {
    terminal: "alacritty";     // Or kitty, wezterm, etc.
}
```

---

## Advanced Features

### Custom Modi Scripts

Create custom modes with shell scripts:

**Example: Clipboard Manager**

Create `~/.config/rofi/scripts/clipboard.sh`:
```bash
#!/bin/bash

# Read clipboard history (requires copyq or similar)
copyq read 0
copyq read 1
copyq read 2
# ... etc
```

Add to config:
```rasi
modi: "drun,run,clipboard:~/.config/rofi/scripts/clipboard.sh";
```

### Rofi as dmenu Replacement

Use Rofi as a dmenu replacement:
```bash
echo -e "Option 1\nOption 2\nOption 3" | rofi -dmenu
```

### Power Menu Example

Create `~/.config/rofi/scripts/powermenu.sh`:
```bash
#!/bin/bash

options="⏻ Shutdown\n⏾ Reboot\n Lock\n Logout"

chosen=$(echo -e "$options" | rofi -dmenu -p "Power Menu")

case $chosen in
    *Shutdown) systemctl poweroff ;;
    *Reboot) systemctl reboot ;;
    *Lock) gnome-screensaver-command -l ;;
    *Logout) gnome-session-quit --logout ;;
esac
```

Make executable and bind to a key:
```bash
chmod +x ~/.config/rofi/scripts/powermenu.sh
```

---

## Troubleshooting

### Issue: Rofi doesn't open with Alt+Space

**Solution:**
```bash
# Check if keybinding is set
gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings

# If empty, re-run the keybinding setup commands
# Make sure launcher.sh is executable
chmod +x ~/.config/rofi/launcher.sh

# Test manually
~/.config/rofi/launcher.sh
```

### Issue: Icons not showing

**Solution:**
```bash
# Make sure show-icons is enabled
grep "show-icons" ~/.config/rofi/config.rasi
# Should show: show-icons: true;

# Install icon theme
sudo apt install papirus-icon-theme

# Set in GTK settings
gsettings set org.gnome.desktop.interface icon-theme 'Papirus'
```

### Issue: Font not found

**Solution:**
```bash
# Check available fonts
fc-list | grep -i "jetbrains"

# If not found, install Nerd Font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip
fc-cache -fv
```

### Issue: Config not loading

**Solution:**
```bash
# Check config syntax
rofi -dump-config > /tmp/rofi-test.rasi

# Look for errors
rofi -show drun -config ~/.config/rofi/config.rasi

# Reset to defaults
mv ~/.config/rofi/config.rasi ~/.config/rofi/config.rasi.backup
rofi -dump-config > ~/.config/rofi/config.rasi
```

### Issue: Wrong terminal opens

**Solution:**
Edit `~/.config/rofi/config.rasi`:
```rasi
terminal: "your-terminal-name";
```

Common terminal names:
- `gnome-terminal`
- `alacritty`
- `kitty`
- `wezterm`
- `xfce4-terminal`

### Issue: Slow startup

**Solution:**
```bash
# Disable file browser and SSH if not needed
modi: "drun,run,window";

# Reduce number of visible items
lines: 8;

# Disable sorting
sort: false;
```

### Issue: Rofi behind other windows

**Solution:**
Add to config:
```rasi
configuration {
    steal-focus: true;
}
```

---

## Command Reference

### Basic Usage

```bash
# Launch application launcher
rofi -show drun

# Launch run dialog
rofi -show run

# Launch window switcher
rofi -show window

# Launch with specific theme
rofi -show drun -theme ~/.config/rofi/mytheme.rasi

# Launch in dmenu mode
echo -e "Option 1\nOption 2" | rofi -dmenu
```

### Testing & Debugging

```bash
# Dump current config
rofi -dump-config

# Dump theme
rofi -dump-theme

# Show available themes
rofi -dump-available-themes

# Test config syntax
rofi -show drun -config ~/.config/rofi/config.rasi

# Show version
rofi -version

# Show help
rofi -help
```

---

## Integration with Other Tools

### Alfred-like Workflow

Rofi can be combined with scripts to create Alfred-like workflows:

```bash
# Calculator
echo "2+2" | rofi -dmenu -p "Calc" | bc

# Web search
search=$(rofi -dmenu -p "Search")
firefox "https://google.com/search?q=$search"
```

### File Manager Integration

Launch Rofi file browser from file manager:
```bash
rofi -show filebrowser -filebrowser-command 'xdg-open'
```

---

## Additional Resources

- **Official Documentation**: https://github.com/davatorium/rofi
- **Themes Collection**: https://github.com/lr-tech/rofi-themes-collection
- **Wiki**: https://github.com/davatorium/rofi/wiki
- **Custom Scripts**: https://github.com/adi1090x/rofi

---

## Quick Setup Summary

1. **Install Rofi**: `sudo apt install rofi`
2. **Create config dir**: `mkdir -p ~/.config/rofi`
3. **Copy config files**:
   - `~/.config/rofi/config.rasi`
   - `~/.config/rofi/launcher.sh`
4. **Make launcher executable**: `chmod +x ~/.config/rofi/launcher.sh`
5. **Set keybinding**: Alt+Space → Run `~/.config/rofi/launcher.sh`
6. **Test**: Press `Alt+Space`

---

## File Locations Summary

```
~/.config/rofi/
├── config.rasi          # Main configuration file
├── launcher.sh          # Launch script
└── scripts/             # Custom scripts (optional)
    ├── powermenu.sh
    ├── clipboard.sh
    └── ...
```

---

## Keybinding Summary

| Key | Action |
|-----|--------|
| `Alt+Space` | Open Rofi launcher |
| `Escape` | Close Rofi |
| `↑/↓` or `Ctrl+k/j` | Navigate items |
| `Enter` | Launch/Select |
| `Alt+Tab` | Switch modes |
| `Ctrl+c` | Cancel |

---

Generated: 2025-12-03
Version: 1.0
Rofi Version: 1.7.5
