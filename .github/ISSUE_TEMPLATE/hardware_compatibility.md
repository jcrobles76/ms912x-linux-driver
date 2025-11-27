---
name: Hardware Compatibility Report
about: Report compatibility with your hardware
title: '[COMPAT] '
labels: hardware-compatibility
assignees: ''
---

## Compatibility Status
<!-- Does it work? -->
- [ ] ✅ Working perfectly
- [ ] ⚠️ Working with issues (describe below)
- [ ] ❌ Not working

## Hardware Information

**USB Device:**
```bash
lsusb | grep 534d
# Paste output here
```

**Monitor:**
- Model:
- Native Resolution:
- Connection Type: HDMI / VGA

**Computer:**
- Model:
- CPU:
- RAM:

## Software Information

**Distribution:**
<!-- e.g., Ubuntu 24.04 LTS, Fedora 40, etc. -->

**Kernel Version:**
```bash
uname -r
# Paste output here
```

**Desktop Environment:**
<!-- e.g., GNOME (Wayland), KDE Plasma, XFCE, etc. -->

**Driver Version:**
```bash
dkms status | grep ms912x
# Paste output here
```

## Test Results

**Installation:**
- [ ] Package installed successfully
- [ ] DKMS build successful
- [ ] Module loads without errors

**Display Detection:**
```bash
cat /sys/class/drm/card0-HDMI-A-3/status
cat /sys/class/drm/card0-HDMI-A-3/modes
# Paste output here
```

**Activation:**
- [ ] Auto-activation works
- [ ] Manual activation works (`modetest`)
- [ ] Appears in display settings

**Performance:**
- Resolution used:
- Refresh rate:
- Use case: Office work / Development / Video / Gaming / Other
- Performance rating: Excellent / Good / Acceptable / Poor

## Issues (if any)
<!-- Describe any problems or limitations -->

## Additional Notes
<!-- Any other relevant information, workarounds, tips -->

---

Thank you for testing and reporting! 🙏
