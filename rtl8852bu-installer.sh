#!/bin/bash
# RTL8852BU WiFi 6 Adapter Installation Script
# For USB ID 0bda:b832 and similar devices

set -e

echo "RTL8852BU (WiFi 6) USB Adapter Installation Script"
echo "================================================="
echo

# Check if running as root
if [ "$EUID" -eq 0 ]; then 
   echo "Please don't run this script as root. It will use sudo when needed."
   exit 1
fi

# Detect Ubuntu version
UBUNTU_VERSION=$(lsb_release -rs 2>/dev/null || echo "unknown")
echo "Detected Ubuntu version: $UBUNTU_VERSION"

# Install dependencies
echo "Installing required packages..."
sudo apt update
sudo apt install -y make gcc build-essential git dkms linux-headers-$(uname -r)

# Check if device is connected
if lsusb | grep -q "0bda:b832"; then
    echo "Realtek RTL8852BU device detected!"
else
    echo "Warning: RTL8852BU device (0bda:b832) not detected, but continuing anyway..."
fi

# Clone the driver repository
echo "Downloading driver source..."
cd /tmp
rm -rf rtl8852bu-driver
git clone --depth 1 https://github.com/morrownr/rtl8852bu-20240418.git rtl8852bu-driver
cd rtl8852bu-driver

# Install the driver
echo "Installing driver (this may take several minutes)..."
chmod +x install-driver.sh
sudo ./install-driver.sh

# Clean up
cd /
rm -rf /tmp/rtl8852bu-driver

echo
echo "Installation complete!"
echo "The driver should now be loaded. You can verify with:"
echo "  lsmod | grep 8852bu"
echo "  ip link show"
echo
echo "If the device isn't working, try:"
echo "  1. Unplug and replug the USB adapter"
echo "  2. Reboot your system"
echo "  3. Check dmesg for any error messages"
echo
echo "To optimize performance, you can edit /etc/modprobe.d/8852bu.conf"
echo "and change rtw_switch_usb_mode=0 to rtw_switch_usb_mode=1 for USB 3.0 mode."