# RTL8852BU Easy Installation

## One-Line Install (for the brave)

```bash
curl -sSL https://raw.githubusercontent.com/GlassOnTin/rtl8852bu-easy-install/main/rtl8852bu-installer.sh | bash
```

## Recommended Install

```bash
# Download the installer
wget https://raw.githubusercontent.com/GlassOnTin/rtl8852bu-easy-install/main/rtl8852bu-installer.sh

# Review the script (always a good idea!)
less rtl8852bu-installer.sh

# Make it executable and run
chmod +x rtl8852bu-installer.sh
./rtl8852bu-installer.sh
```

## What This Does

1. Installs necessary build tools and kernel headers
2. Downloads the latest RTL8852BU driver from morrownr's repository
3. Builds and installs the driver using DKMS
4. Loads the module automatically

## Supported Devices

- USB ID: 0bda:b832 (Realtek RTL8852BU)
- Other RTL8852BU/RTL8832BU based adapters

## Tested On

- Ubuntu 22.04 LTS
- Ubuntu 24.04 LTS
- Ubuntu 25.04
- Debian 11/12
- Linux Mint 21/22

## Need Help?

Check the full README.md for troubleshooting steps and manual installation instructions.