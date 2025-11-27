# Contributing to MS912x Linux Driver

Thank you for your interest in contributing! 🎉

## How to Contribute

### Reporting Issues

If you encounter problems:

1. Check the [INSTALLATION.md](INSTALLATION.md) troubleshooting section
2. Search [existing issues](https://github.com/jcrobles76/ms912x-linux-driver/issues)
3. Open a new issue with:
   - Your distribution and kernel version (`uname -a`)
   - Device ID (`lsusb | grep 534d`)
   - Error messages (`dmesg | grep ms912x`)
   - Steps to reproduce

### Hardware Compatibility Reports

Help expand device support:

- Test on different distributions
- Report success/failure with your hardware
- Include: distro, kernel version, device ID, monitor model

### Code Contributions

1. **Fork** the repository
2. **Create a branch**: `git checkout -b feature/your-feature`
3. **Make changes** and test thoroughly
4. **Commit**: Follow conventional commits format
5. **Push**: `git push origin feature/your-feature`
6. **Open a Pull Request**

#### Commit Message Format

```
type(scope): subject

body (optional)

footer (optional)
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

Example:
```
feat(dkms): add support for kernel 6.15+

Updated DRM API calls to support new kernel version.
Tested on Ubuntu 24.04 with kernel 6.15.0-rc1.

Closes #123
```

### Testing

Before submitting:

1. Test on a clean system
2. Verify DKMS builds correctly
3. Test installation from package
4. Check display activation
5. Verify uninstallation works

### Documentation

Improvements to docs are always welcome:

- Fix typos or clarify instructions
- Add troubleshooting for new issues
- Translate to other languages
- Add examples or screenshots

### Package Maintenance

Help maintain packages:

- Test on new kernel versions
- Update for new distro releases
- Improve build scripts
- Add support for more package formats (AUR, etc.)

## Development Setup

```bash
# Clone the repo
git clone https://github.com/jcrobles76/ms912x-linux-driver.git
cd ms912x-linux-driver

# Install build dependencies
sudo apt install dkms build-essential linux-headers-$(uname -r) libdrm-tests

# The source is in a separate repo - clone it
git clone https://github.com/nunesbns/ms912x.git -b kernel-6-support
```

## Code Style

- Follow Linux kernel coding style
- Use tabs for indentation in C code
- Keep lines under 80 characters when possible
- Comment complex logic

## Questions?

Feel free to open a [discussion](https://github.com/jcrobles76/ms912x-linux-driver/discussions) or issue!

## License

By contributing, you agree that your contributions will be licensed under GPL-2.0.

---

Thank you for helping improve MS912x Linux driver support! 🙏
