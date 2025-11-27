#!/bin/bash
# MacroSilicon MS912x Compatibility Checker
# This script checks if your system is compatible with the ms912x driver

echo "=========================================="
echo "MS912x Driver Compatibility Checker"
echo "=========================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

ERRORS=0
WARNINGS=0

# Check 1: Kernel version
echo -n "Checking kernel version... "
KERNEL_VERSION=$(uname -r | cut -d. -f1-2)
KERNEL_MAJOR=$(echo $KERNEL_VERSION | cut -d. -f1)
KERNEL_MINOR=$(echo $KERNEL_VERSION | cut -d. -f2)

if [ "$KERNEL_MAJOR" -gt 5 ] || ([ "$KERNEL_MAJOR" -eq 5 ] && [ "$KERNEL_MINOR" -ge 10 ]); then
    echo -e "${GREEN}✓${NC} $(uname -r)"
else
    echo -e "${RED}✗${NC} $(uname -r) - Kernel 5.10+ required"
    ((ERRORS++))
fi

# Check 2: USB device present
echo -n "Checking for MacroSilicon device... "
if lsusb | grep -q "534d:6021\|534d:0821"; then
    DEVICE_INFO=$(lsusb | grep "534d:6021\|534d:0821")
    echo -e "${GREEN}✓${NC} Found: $DEVICE_INFO"
else
    echo -e "${YELLOW}⚠${NC} Not detected (this is OK if not connected yet)"
    ((WARNINGS++))
fi

# Check 3: DKMS installed
echo -n "Checking for DKMS... "
if command -v dkms &> /dev/null; then
    DKMS_VERSION=$(dkms --version | head -n1)
    echo -e "${GREEN}✓${NC} $DKMS_VERSION"
else
    echo -e "${RED}✗${NC} Not installed"
    echo "  Install with: sudo apt install dkms  (Ubuntu/Debian)"
    echo "            or: sudo dnf install dkms  (Fedora/RHEL)"
    ((ERRORS++))
fi

# Check 4: Build tools
echo -n "Checking for build tools... "
if command -v gcc &> /dev/null && command -v make &> /dev/null; then
    GCC_VERSION=$(gcc --version | head -n1 | awk '{print $3}')
    echo -e "${GREEN}✓${NC} gcc $GCC_VERSION, make installed"
else
    echo -e "${RED}✗${NC} Not installed"
    echo "  Install with: sudo apt install build-essential  (Ubuntu/Debian)"
    echo "            or: sudo dnf install gcc make          (Fedora/RHEL)"
    ((ERRORS++))
fi

# Check 5: Kernel headers
echo -n "Checking for kernel headers... "
if [ -d "/lib/modules/$(uname -r)/build" ]; then
    echo -e "${GREEN}✓${NC} Installed for $(uname -r)"
else
    echo -e "${RED}✗${NC} Not installed"
    echo "  Install with: sudo apt install linux-headers-\$(uname -r)  (Ubuntu/Debian)"
    echo "            or: sudo dnf install kernel-devel                (Fedora/RHEL)"
    ((ERRORS++))
fi

# Check 6: libdrm-tests (modetest)
echo -n "Checking for modetest utility... "
if command -v modetest &> /dev/null; then
    echo -e "${GREEN}✓${NC} Installed"
else
    echo -e "${YELLOW}⚠${NC} Not installed (recommended)"
    echo "  Install with: sudo apt install libdrm-tests  (Ubuntu/Debian)"
    echo "            or: sudo dnf install libdrm         (Fedora/RHEL)"
    ((WARNINGS++))
fi

# Check 7: Free USB ports
echo -n "Checking USB subsystem... "
if command -v lsusb &> /dev/null; then
    USB_DEVICES=$(lsusb | wc -l)
    echo -e "${GREEN}✓${NC} $USB_DEVICES USB devices detected"
else
    echo -e "${YELLOW}⚠${NC} lsusb not available"
    ((WARNINGS++))
fi

# Check 8: DRM subsystem
echo -n "Checking DRM subsystem... "
if [ -d "/sys/class/drm" ]; then
    DRM_CARDS=$(ls /sys/class/drm/ | grep "^card[0-9]$" | wc -l)
    echo -e "${GREEN}✓${NC} $DRM_CARDS display card(s) detected"
else
    echo -e "${RED}✗${NC} DRM not available"
    ((ERRORS++))
fi

# Summary
echo ""
echo "=========================================="
echo "Summary"
echo "=========================================="
echo ""

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✓ Your system is fully compatible!${NC}"
    echo ""
    echo "You can proceed with installation:"
    echo ""
    if [ -f /etc/debian_version ]; then
        echo "  sudo dpkg -i ms912x-dkms-1.0.0.deb"
    elif [ -f /etc/redhat-release ]; then
        echo "  sudo rpm -ivh ms912x-dkms-1.0.0-1.noarch.rpm"
    else
        echo "  See INSTALLATION.md for your distribution"
    fi
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}⚠ Your system is compatible with minor warnings${NC}"
    echo "  $WARNINGS warning(s) found - driver should work but some features may be limited"
    echo ""
    echo "  Please review the warnings above before installation."
else
    echo -e "${RED}✗ Your system has compatibility issues${NC}"
    echo "  $ERRORS error(s) found - please fix them before installation"
    echo "  $WARNINGS warning(s) found"
    echo ""
    echo "  Please install the required packages listed above."
fi

echo ""
echo "For detailed documentation, see INSTALLATION.md"
echo ""

exit $ERRORS
