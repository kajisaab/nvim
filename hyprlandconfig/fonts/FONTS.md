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
