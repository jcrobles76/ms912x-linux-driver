# MacroSilicon MS912x USB Display Driver for Linux
## Installation Guide

**Version:** 1.0.0
**Date:** November 27, 2024
**Compatible Kernels:** Linux 5.10+ (tested on 6.14.0)

---

## Supported Hardware

This driver supports MacroSilicon MS912x USB to HDMI/VGA display adapters:

- **Device ID:** 534d:6021 (MacroSilicon MS9120)
- **Device ID:** 534d:0821 (MacroSilicon MS9120 variant)

These chipsets are commonly found in:
- Generic USB to HDMI adapters
- USB to VGA adapters
- USB 3.0 display adapters
- Portable USB monitors

To check if you have a compatible device:
```bash
lsusb | grep 534d
```

---

## Package Information

This repository contains two package formats:

| Package | Size | For Distributions |
|---------|------|-------------------|
| `ms912x-dkms-1.0.0.deb` | 13 KB | Ubuntu, Debian, Linux Mint, Pop!_OS, Elementary OS |
| `ms912x-dkms-1.0.0-1.noarch.rpm` | 22 KB | Fedora, RHEL, CentOS, AlmaLinux, Rocky Linux, openSUSE |

Both packages use **DKMS** (Dynamic Kernel Module Support) to automatically recompile the driver when you update your kernel.

---

## Installation Instructions

### For Ubuntu/Debian-based Systems (.deb)

```bash
# 1. Install dependencies
sudo apt update
sudo apt install dkms libdrm-tests build-essential linux-headers-$(uname -r)

# 2. Install the driver package
sudo dpkg -i ms912x-dkms-1.0.0.deb

# 3. If there are dependency errors, fix them:
sudo apt-get install -f

# 4. Verify installation
lsmod | grep ms912x
dkms status
```

### For Fedora/RHEL-based Systems (.rpm)

```bash
# 1. Install dependencies
sudo dnf install dkms libdrm kernel-devel gcc make

# Or for older systems (RHEL/CentOS 7):
sudo yum install dkms libdrm kernel-devel gcc make

# 2. Install the driver package
sudo rpm -ivh ms912x-dkms-1.0.0-1.noarch.rpm

# 3. Verify installation
lsmod | grep ms912x
dkms status
```

---

## Usage

### Automatic Mode (Recommended)

Once installed, the driver works automatically:

1. **Connect your USB display adapter** to a USB port
2. **Attach a monitor** to the adapter's HDMI/VGA port
3. **Turn on the monitor**
4. The display should activate automatically within a few seconds

### Manual Activation

If the display doesn't activate automatically:

```bash
# Run the setup script
sudo /usr/local/bin/ms912x-display-setup.sh

# Or activate manually with modetest
sudo modetest -M ms912x -s 32:1920x1080
```

### Check Display Status

```bash
# Check if module is loaded
lsmod | grep ms912x

# View kernel messages
sudo dmesg | grep ms912x

# Check display connection status
cat /sys/class/drm/card0-HDMI-A-3/status

# View available resolutions
cat /sys/class/drm/card0-HDMI-A-3/modes
sudo modetest -M ms912x
```

---

## Supported Resolutions

The driver supports the following resolutions at 60Hz:

- **1920x1080** (Full HD) ← Recommended
- 1680x1050
- 1440x900
- 1400x1050
- 1366x768
- 1280x1024
- 1280x960
- 1280x800
- 1280x720
- 1024x768
- 800x600

---

## Known Limitations

### Display Not Appearing in xrandr

**Issue:** The USB display may not appear in `xrandr` output.

**Cause:** X11 has limitations with multiple GPU providers, especially USB displays on different DRM cards.

**Solutions:**
- Use the manual activation script: `sudo /usr/local/bin/ms912x-display-setup.sh`
- Use Wayland instead of X11 (better multi-GPU support)
- Use the display as a standalone screen (not extended desktop)

### Performance Considerations

- USB displays have inherent bandwidth limitations compared to native displays
- Video playback may have reduced frame rates
- Best suited for productivity applications, coding, documentation, etc.
- Not recommended for gaming or high-motion video

### Desktop Environment Compatibility

| Environment | Compatibility | Notes |
|-------------|--------------|-------|
| GNOME (Wayland) | Good | Better multi-display support |
| KDE Plasma | Good | Works with manual configuration |
| GNOME (X11) | Limited | May not appear in display settings |
| XFCE | Limited | Manual activation required |
| i3/Sway | Good | Wayland version (Sway) works well |

---

## Troubleshooting

### Module Not Loading

```bash
# Check DKMS status
dkms status

# Rebuild module
sudo dkms build -m ms912x -v 1.0.0
sudo dkms install -m ms912x -v 1.0.0

# Load module manually
sudo modprobe ms912x
```

### Display Not Detected

```bash
# Verify USB device is connected
lsusb | grep 534d

# Check kernel messages for errors
sudo dmesg | tail -50 | grep -i "ms912x\|drm\|usb"

# Force udev trigger
sudo udevadm control --reload-rules
sudo udevadm trigger
```

### Display Shows Pattern But No Desktop

This is expected behavior when using `modetest`. The driver activates the hardware but X11/Wayland integration is limited.

**Workaround for productivity:**
- Use the display as a mirrored screen
- Configure a separate X session for the USB display
- Use Wayland compositor with better multi-GPU support

### Error: -ENOMEM When Reading Modes

This usually indicates the monitor is not properly connected or powered on.

**Solutions:**
1. Ensure monitor is powered on
2. Check HDMI/VGA cable connection
3. Try unplugging and replugging the USB adapter
4. Try a different USB port (preferably USB 3.0)

---

## Uninstallation

### Ubuntu/Debian
```bash
sudo apt-get remove ms912x-dkms
sudo apt-get autoremove
```

### Fedora/RHEL
```bash
sudo rpm -e ms912x-dkms
```

The uninstallation will:
- Remove the kernel module from DKMS
- Unload the driver
- Remove configuration files
- Clean up udev rules

---

## Technical Details

### Files Installed

```
/usr/src/ms912x-1.0.0/           - Driver source code
/usr/local/bin/ms912x-display-setup.sh - Auto-activation script
/etc/udev/rules.d/99-ms912x.rules - USB hotplug rules
/etc/modules-load.d/ms912x.conf  - Module autoload config
/usr/share/doc/ms912x-dkms/      - Documentation
```

### How It Works

1. **USB Hotplug:** When you connect the device, udev detects it
2. **Module Loading:** The ms912x kernel module loads automatically
3. **Display Detection:** The driver reads EDID from the connected monitor
4. **Mode Setting:** A compatible resolution is selected and activated
5. **Frame Transfer:** Video data is sent to the device via USB bulk transfer
6. **Display Output:** The device converts digital data to HDMI/VGA signal

### Architecture

```
Application Layer (X11/Wayland)
         ↓
   DRM Subsystem
         ↓
   ms912x Driver
         ↓
   USB Subsystem
         ↓
MacroSilicon Hardware
         ↓
   Monitor (HDMI/VGA)
```

---

## Credits & License

### Original Driver
- **Author:** rhgndf
- **Repository:** https://github.com/rhgndf/ms912x
- **License:** GPL-2.0

### Kernel 6.14+ Adaptations & Packaging
- **Contributor:** Carlos
- **Modifications:**
  - Updated DRM EDID API for kernel 6.14+
  - Removed deprecated driver structure fields
  - Added DKMS support
  - Created Debian and RPM packages
  - Added auto-activation scripts
  - Comprehensive documentation

### License
This driver is licensed under **GPL-2.0** (same as the Linux kernel).

---

## Support & Contributions

### Reporting Issues

If you encounter problems:

1. Check the troubleshooting section above
2. Review kernel messages: `sudo dmesg | grep ms912x`
3. Visit the original repository: https://github.com/rhgndf/ms912x
4. Ensure your kernel version is supported (5.10+)

### Hardware Compatibility

Successfully tested on:
- Ubuntu 24.04 LTS (Kernel 6.14.0-36-generic)
- Lenovo Z50-70 laptop
- MacroSilicon 534d:6021 device
- Acer S235HL monitor (1920x1080)

If you test on other hardware/distributions, please share your results!

### Contributing

Contributions are welcome:
- Test on different distributions
- Report compatibility issues
- Suggest improvements
- Submit patches for newer kernel versions

---

## Frequently Asked Questions

**Q: Will this work on any USB display adapter?**
A: No, only devices with MacroSilicon MS912x chipsets (VID:PID 534d:6021 or 534d:0821).

**Q: Do I need to reinstall after kernel updates?**
A: No! DKMS automatically rebuilds the driver when you update your kernel.

**Q: Can I use this as a primary display?**
A: Yes, but it's better suited as a secondary display due to USB bandwidth limitations.

**Q: Does this support DisplayLink devices?**
A: No, this is specifically for MacroSilicon chipsets. DisplayLink devices need the displaylink driver.

**Q: Why doesn't it appear in my desktop display settings?**
A: This is a limitation of X11 with multiple GPU providers. Use manual activation or Wayland.

**Q: What's the maximum resolution supported?**
A: 1920x1080 @ 60Hz is the maximum reliable resolution.

**Q: Will this work on Raspberry Pi?**
A: Yes, if you compile it for ARM architecture and have DKMS installed.

---

## Changelog

### Version 1.0.0 (2024-11-27)
- Initial release
- Support for Linux kernel 6.14+
- DKMS packaging for Debian and RPM
- Automatic display activation
- udev rules for hotplug support
- Comprehensive documentation

---

**Thank you for using the MS912x Linux driver!**

If this driver helped you, please consider:
- Starring the original repository: https://github.com/rhgndf/ms912x
- Sharing this package with others who have the same hardware
- Contributing improvements back to the community

Happy multi-monitoring! 🖥️🖥️
