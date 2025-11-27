# MacroSilicon MS912x Linux Driver Packages

![License](https://img.shields.io/badge/license-GPL--2.0-blue.svg)
![Version](https://img.shields.io/badge/version-1.0.0-green.svg)
![Kernel](https://img.shields.io/badge/kernel-5.10+-orange.svg)

Linux kernel driver packages for **MacroSilicon MS912x** USB to HDMI/VGA display adapters.

## 📦 Download

| Package | Distribution | Size |
|---------|-------------|------|
| [ms912x-dkms-1.0.0.deb](ms912x-dkms-1.0.0.deb) | Ubuntu, Debian, Mint | 13 KB |
| [ms912x-dkms-1.0.0-1.noarch.rpm](ms912x-dkms-1.0.0-1.noarch.rpm) | Fedora, RHEL, CentOS | 22 KB |

## 🔌 Supported Hardware

- **MacroSilicon MS9120** (VID:PID `534d:6021`)
- **MacroSilicon MS9120** (VID:PID `534d:0821`)

Check compatibility: `lsusb | grep 534d`

## ⚡ Quick Install

### Ubuntu/Debian
```bash
sudo apt install dkms libdrm-tests
sudo dpkg -i ms912x-dkms-1.0.0.deb
```

### Fedora/RHEL
```bash
sudo dnf install dkms libdrm
sudo rpm -ivh ms912x-dkms-1.0.0-1.noarch.rpm
```

## ✨ Features

- ✅ Automatic compilation for any kernel (DKMS)
- ✅ Hotplug support via udev rules
- ✅ Auto-detection and activation of displays
- ✅ Resolutions up to 1920x1080@60Hz
- ✅ Compatible with Linux kernel 6.14+

## 📖 Full Documentation

See [INSTALLATION.md](INSTALLATION.md) for:
- Detailed installation instructions
- Troubleshooting guide
- Usage examples
- Technical details

## 🏆 Credits

- **Original Driver:** [rhgndf/ms912x](https://github.com/rhgndf/ms912x)
- **Kernel 6.14+ Adaptations & Packaging:** Carlos

## 📄 License

GPL-2.0 (same as Linux kernel)

---

**Need help?** Read the [INSTALLATION.md](INSTALLATION.md) guide or check the [original repository](https://github.com/rhgndf/ms912x).
