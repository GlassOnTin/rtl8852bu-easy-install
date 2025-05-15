#!/bin/bash
# RTL8852BU Driver Status Check Script

echo "RTL8852BU Driver Status Check"
echo "============================="
echo

# Check if device is connected
echo "USB Device Status:"
if lsusb | grep -q "0bda:b832"; then
    echo "✓ RTL8852BU device detected"
    lsusb | grep "0bda:b832"
else
    echo "✗ RTL8852BU device not detected"
fi
echo

# Check if driver is loaded
echo "Driver Status:"
if lsmod | grep -q "8852bu"; then
    echo "✓ 8852bu driver is loaded"
    echo "Module info:"
    lsmod | grep 8852bu
else
    echo "✗ 8852bu driver is not loaded"
fi
echo

# Check DKMS status
echo "DKMS Status:"
if command -v dkms &> /dev/null; then
    dkms status | grep 8852bu || echo "No 8852bu module in DKMS"
else
    echo "DKMS not installed"
fi
echo

# Check network interfaces
echo "Network Interfaces:"
echo "Active WiFi interfaces:"
ip link show | grep -E "wl[a-z0-9]+" | while read -r line; do
    iface=$(echo $line | cut -d: -f2 | tr -d ' ')
    echo "  $iface"
done
echo

# Check current connection
echo "Current WiFi Status:"
nmcli device status | grep wifi || echo "No WiFi devices found"
echo

# Additional info
echo "System Information:"
echo "Kernel: $(uname -r)"
echo "Distribution: $(lsb_release -d | cut -f2)"
echo

echo "For more details, check:"
echo "  dmesg | grep -i 8852bu"
echo "  journalctl -xe | grep -i 8852bu"