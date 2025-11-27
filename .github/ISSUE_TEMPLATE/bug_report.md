---
name: Bug Report
about: Report a problem with the MS912x driver
title: '[BUG] '
labels: bug
assignees: ''
---

## Bug Description
<!-- A clear description of what the bug is -->

## System Information
**Distribution:**
<!-- e.g., Ubuntu 24.04 LTS -->

**Kernel Version:**
```bash
uname -r
# Paste output here
```

**Driver Version:**
```bash
dkms status | grep ms912x
# Paste output here
```

**Device Information:**
```bash
lsusb | grep 534d
# Paste output here
```

## Steps to Reproduce
1.
2.
3.

## Expected Behavior
<!-- What you expected to happen -->

## Actual Behavior
<!-- What actually happened -->

## Error Messages
```bash
sudo dmesg | grep ms912x | tail -20
# Paste output here
```

## Display Status
```bash
cat /sys/class/drm/card0-HDMI-A-3/status
cat /sys/class/drm/card0-HDMI-A-3/modes
# Paste output here
```

## Additional Context
<!-- Screenshots, workarounds, or other relevant information -->

## Checklist
- [ ] I have read the [INSTALLATION.md](../INSTALLATION.md) guide
- [ ] I have checked the troubleshooting section
- [ ] I have searched for similar issues
- [ ] I have included all required system information
