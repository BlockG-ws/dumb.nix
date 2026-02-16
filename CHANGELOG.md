# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- Removed Cachix integration from build workflow to fix secrets configuration issues

## [0.1.0] - 2026-02-16

### Added
- Initial NixOS Live ISO configuration with comprehensive features
- XFCE4 desktop environment with auto-login
- fcitx5 input method with Chinese support (Pinyin)
- Pre-installed hardware testing tools:
  - stress-ng, memtest86plus for system testing
  - lshw, hwinfo, dmidecode, inxi for hardware information
  - smartmontools, hdparm, nvme-cli for disk diagnostics
- Windows system maintenance tools:
  - chntpw for password reset
  - wimlib for WIM/ESD image handling
  - ntfsprogs for NTFS filesystem operations
  - ms-sys for boot repair
- Backup and recovery tools:
  - Clonezilla with server support
  - testdisk and photorec for data recovery
  - ddrescue for damaged disk recovery
  - partclone, fsarchiver for partition backup
- Complete driver support including:
  - Intel and AMD CPU microcode updates
  - GPU drivers (Intel, AMD, NVIDIA via nouveau)
  - All common filesystem support (ext4, NTFS, Btrfs, XFS, ZFS, etc.)
  - Bluetooth and WiFi firmware
- Network tools (nmap, tcpdump, wireshark, iperf3, mtr)
- SSH server enabled by default with root access
- ZFS filesystem support with chroot capabilities
- Secure boot support via shim
- Chinese localization and fonts
- Comprehensive documentation:
  - English README
  - Chinese README (README_CN.md)
  - Installation guide (INSTALL.md)
  - Quick start guide (QUICKSTART.md)
  - Tool reference (TOOLS.md)
  - Contributing guidelines (CONTRIBUTING.md)
- GitHub Actions workflow for automatic ISO building
- Automated release with checksums
- Build script for local development

### Security
- Root password set to "nixos" (for live system convenience)
- User "nixos" with sudo access (password: "nixos")
- SSH enabled with password authentication
- Firewall disabled by default (live system)

### Configuration
- Default locale: zh_CN.UTF-8
- Timezone: Asia/Shanghai
- Network: NetworkManager enabled
- Desktop: XFCE4 with LightDM auto-login
- Input: fcitx5 with Chinese addons

## Release Notes

This is the initial release of Dumb NixOS Live ISO. The system is designed for:
- System administration and maintenance
- Hardware diagnostics and testing
- Windows system rescue and repair
- Data backup and recovery
- Disk cloning and imaging
- Emergency system access

All tools are pre-configured and ready to use out of the box.

---

[Unreleased]: https://github.com/BlockG-ws/dumb.nix/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/BlockG-ws/dumb.nix/releases/tag/v0.1.0
