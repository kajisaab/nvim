#!/bin/bash
# Extract SDDM theme - Run this manually (requires sudo password)

echo "Extracting SDDM login theme..."
echo "This requires your sudo password."
echo ""

mkdir -p ~/Documents/hyprlandconfig/sddm

# Copy SDDM config
echo "Copying SDDM config..."
sudo cp /etc/sddm.conf ~/Documents/hyprlandconfig/sddm/
sudo chown $USER:$USER ~/Documents/hyprlandconfig/sddm/sddm.conf

# Copy SDDM theme
echo "Copying SDDM theme..."
sudo cp -r /usr/share/sddm/themes/simple-sddm-2 ~/Documents/hyprlandconfig/sddm/
sudo chown -R $USER:$USER ~/Documents/hyprlandconfig/sddm/simple-sddm-2

echo ""
echo "✓ SDDM theme extraction complete!"
echo ""
echo "Extracted:"
echo "  - /etc/sddm.conf → ~/Documents/hyprlandconfig/sddm/sddm.conf"
echo "  - SDDM theme → ~/Documents/hyprlandconfig/sddm/simple-sddm-2/"
