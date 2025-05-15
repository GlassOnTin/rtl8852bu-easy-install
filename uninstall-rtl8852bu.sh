#!/bin/bash
# RTL8852BU Driver Uninstaller Script

set -e

echo "RTL8852BU Driver Uninstaller"
echo "==========================="
echo

read -p "Are you sure you want to uninstall the RTL8852BU driver? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Uninstall cancelled."
    exit 0
fi

# Unload the module if loaded
if lsmod | grep -q "8852bu"; then
    echo "Unloading 8852bu module..."
    sudo modprobe -r 8852bu
fi

# Remove from DKMS if present
if command -v dkms &> /dev/null && dkms status | grep -q "8852bu"; then
    echo "Removing from DKMS..."
    VERSION=$(dkms status | grep 8852bu | awk -F, '{print $2}' | tr -d ' ')
    sudo dkms remove rtl8852bu/$VERSION --all
fi

# Remove configuration file
if [ -f /etc/modprobe.d/8852bu.conf ]; then
    echo "Removing configuration file..."
    sudo rm -f /etc/modprobe.d/8852bu.conf
fi

# Remove source if it exists
if [ -d /usr/src/rtl8852bu-* ]; then
    echo "Removing source files..."
    sudo rm -rf /usr/src/rtl8852bu-*
fi

echo
echo "Uninstall complete!"
echo "You may need to reboot for all changes to take effect."
echo
echo "If you want to reinstall, run: ./rtl8852bu-installer.sh"