# Dumb NixOS - Comprehensive Live ISO System

English | [简体中文](README_CN.md)

A powerful NixOS-based Live ISO system designed for system maintenance, hardware testing, and data recovery.

## ✨ Key Features

### 🔐 Secure Boot Support
- Supports UEFI Secure Boot via shim
- Compatible with modern motherboard secure boot configurations
- Supports both legacy BIOS and UEFI boot

### 🛠️ Hardware Testing Tools
Pre-installed with rich hardware testing and diagnostic tools:
- **System Info**: `lshw`, `hwinfo`, `dmidecode`, `inxi`
- **Performance Testing**: `stress`, `stress-ng`, `memtest86plus`
- **Hardware Monitoring**: `lm_sensors`, `smartmontools`
- **USB/PCI**: `lsusb`, `lspci`, `usbutils`, `pciutils`
- **Disk Tools**: `hdparm`, `sdparm`, `nvme-cli`

### 💾 Disk and Filesystem Support
Supports almost all common filesystems:
- Linux: ext2/3/4, XFS, Btrfs, ZFS
- Windows: NTFS, FAT32, exFAT
- Others: UFS, ReiserFS, etc.

### 🪟 Windows System Maintenance
Includes powerful Windows system maintenance tools:
- **Password Reset**: `chntpw` - Reset or remove Windows user passwords
- **WIM/ESD Handling**: `wimlib` - Handle Windows image files
- **NTFS Operations**: `ntfsprogs` - Complete NTFS filesystem toolset
- **Boot Repair**: `ms-sys` - Repair Windows MBR boot

### 💿 Backup and Recovery
- **Clonezilla**: Complete disk cloning and backup solution
- **Other Tools**: `partclone`, `partimage`, `fsarchiver`, `testdisk`, `ddrescue`

### 🌏 Chinese Language Support
- Pre-configured fcitx5 input method framework
- Chinese input methods (Pinyin, Wubi, etc.)
- Pre-installed Chinese fonts
- Default Chinese interface and localization

### 🖥️ XFCE4 Desktop Environment
Lightweight but fully functional desktop environment:
- Fast startup and low memory usage
- Complete file manager (Thunar)
- Terminal, text editor, screenshot tool, etc.
- NetworkManager GUI

### 🌐 Network Features
- **SSH Server**: Pre-enabled for remote access
- **Network Tools**: `nmap`, `tcpdump`, `wireshark`, `mtr`, `iperf3`
- **NetworkManager**: Graphical network configuration

### 🔧 System Maintenance Features
- **Chroot Support**: Easily chroot into other distributions on disk for repair
- **ZFS Support**: Complete ZFS filesystem support
- **Boot Repair**: GRUB2, EFI boot management
- **Partition Tools**: GParted graphical partition editor

## 📦 Installation and Usage

### System Requirements
- CPU: x86_64 (64-bit) processor
- RAM: Minimum 2GB (4GB+ recommended)
- Storage: USB drive or DVD (at least 8GB)
- BIOS: UEFI or legacy BIOS support

### Download ISO
Download the latest ISO from the [Releases](https://github.com/BlockG-ws/dumb.nix/releases) page.

### Create Bootable USB

#### Windows Users
Use [Rufus](https://rufus.ie/) or [balenaEtcher](https://www.balena.io/etcher/):
1. Insert USB drive
2. Open Rufus
3. Select the downloaded ISO file
4. Click "Start"

#### Linux/macOS Users
Use the `dd` command (ensure device path is correct):
```bash
# Find USB device
lsblk

# Write ISO (replace /dev/sdX with your USB device)
sudo dd if=dumb-nixos-*.iso of=/dev/sdX bs=4M status=progress oflag=sync
```

### Boot the System
1. Insert the bootable USB drive
2. Restart computer and enter boot menu (usually F12, F2, ESC, or DEL)
3. Select USB boot
4. System will automatically start and login to XFCE4 desktop

### Default Login Credentials
- **Username**: `alex`
- **Password**: `Dumb.n1x`

## 🔨 Common Use Cases

For detailed usage examples, please refer to [README_CN.md](README_CN.md) (Chinese documentation includes comprehensive examples).

## 🏗️ Building from Source

### Prerequisites
- Install Nix package manager
- Enable flakes experimental feature

### Build Steps
```bash
# Clone repository
git clone https://github.com/BlockG-ws/dumb.nix.git
cd dumb.nix

# Build ISO
nix build .#iso

# ISO file is located at
ls -lh result/iso/*.iso
```

### Customization
Edit `iso.nix` to customize:
- Add or remove packages
- Modify desktop environment settings
- Adjust system configuration
- Change default users and passwords

Then rebuild.

## 🤝 Contributing

Contributions are welcome! Feel free to submit Issues or Pull Requests.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [NixOS](https://nixos.org/) - Excellent Linux distribution
- [Clonezilla](https://clonezilla.org/) - Powerful backup tool
- [XFCE](https://www.xfce.org/) - Lightweight desktop environment
- All open source contributors

## ⚠️ Disclaimer

This tool is for legal use only. When using this tool to modify systems, reset passwords, or access data, please ensure:
1. You have legal permission to access the target system
2. You understand the risks involved
3. You have backed up important data

The author is not responsible for any data loss or system damage caused by using this tool.
