# RTL8852BU WiFi 6 USB Adapter Installation Guide

## Quick Start

1. Download and run the installer script:
   ```bash
   wget https://raw.githubusercontent.com/GlassOnTin/rtl8852bu-installer/main/rtl8852bu-installer.sh
   chmod +x rtl8852bu-installer.sh
   ./rtl8852bu-installer.sh
   ```

## Device Information

- **USB ID**: 0bda:b832
- **Chipset**: RTL8852BU / RTL8832BU
- **Features**: WiFi 6 (802.11ax), USB 3.0 capable
- **Tested on**: Ubuntu 25.04 with kernel 6.14.0

## Manual Installation

If the script doesn't work, follow these steps:

### 1. Install Dependencies
```bash
sudo apt update
sudo apt install -y make gcc build-essential git dkms linux-headers-$(uname -r)
```

### 2. Clone Driver Repository
```bash
git clone --depth 1 https://github.com/morrownr/rtl8852bu-20240418.git
cd rtl8852bu-20240418
```

### 3. Install Driver
```bash
sudo ./install-driver.sh
```

### 4. Load Module (if not automatic)
```bash
sudo modprobe 8852bu
```

## Troubleshooting

### Device Not Detected
1. Check if device is connected:
   ```bash
   lsusb | grep 0bda:b832
   ```

2. Check if module is loaded:
   ```bash
   lsmod | grep 8852bu
   ```

3. Check kernel messages:
   ```bash
   dmesg | grep -i 8852bu
   ```

### Build Errors
- Ensure kernel headers match your running kernel:
  ```bash
  uname -r
  dpkg -l | grep linux-headers
  ```

### Network Interface Issues
- List all network interfaces:
  ```bash
  ip link show
  nmcli device status
  ```

## Performance Optimization

### Enable USB 3.0 Mode
Edit `/etc/modprobe.d/8852bu.conf`:
```bash
sudo nano /etc/modprobe.d/8852bu.conf
```

Change:
```
options 8852bu rtw_switch_usb_mode=0
```

To:
```
options 8852bu rtw_switch_usb_mode=1
```

Then reload the module:
```bash
sudo modprobe -r 8852bu
sudo modprobe 8852bu
```

### 5GHz Band
For better performance, connect to 5GHz networks when available.

## Alternative Drivers

If the morrownr driver doesn't work, try:

1. **lwfinger/rtl8852bu**:
   ```bash
   git clone https://github.com/lwfinger/rtl8852bu.git
   ```

2. **Official Realtek driver**:
   Check the Realtek website for latest drivers

## Known Issues

- May require manual rebuild after kernel updates (DKMS should handle this automatically)
- Some distributions may require additional firmware files
- USB 3.0 mode may cause instability on some systems

## Support

- Driver issues: https://github.com/morrownr/rtl8852bu/issues
- Ubuntu support: https://askubuntu.com
- General Linux wireless: https://wireless.wiki.kernel.org

## License

This guide is provided as-is. The driver itself is subject to its own license terms.