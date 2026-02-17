# Installation Guide / 安装指南

This guide provides detailed instructions for using Dumb NixOS Live ISO.

## Table of Contents
- [Creating Bootable Media](#creating-bootable-media)
- [Booting the System](#booting-the-system)
- [Using the Live System](#using-the-live-system)
- [Advanced Usage](#advanced-usage)

---

## Creating Bootable Media

### Using Rufus (Windows)

1. Download and run [Rufus](https://rufus.ie/)
2. Insert your USB drive (at least 8GB)
3. In Rufus:
   - **Device**: Select your USB drive
   - **Boot selection**: Click "SELECT" and choose the downloaded ISO
   - **Partition scheme**: 
     - For UEFI systems: GPT
     - For BIOS systems: MBR
   - **File system**: FAT32
4. Click "START"
5. If prompted about ISO mode vs DD mode, choose "DD Image mode" for maximum compatibility
6. Wait for completion

### Using balenaEtcher (Windows/macOS/Linux)

1. Download [balenaEtcher](https://www.balena.io/etcher/)
2. Insert USB drive
3. Open Etcher:
   - Click "Flash from file" → select ISO
   - Click "Select target" → select USB drive
   - Click "Flash!"
4. Wait for verification to complete

### Using dd (Linux/macOS)

```bash
# 1. Find your USB device
lsblk  # or diskutil list on macOS

# 2. Unmount the device (if mounted)
sudo umount /dev/sdX*  # Linux
# or
diskutil unmountDisk /dev/diskN  # macOS

# 3. Write ISO to USB
sudo dd if=dumb-nixos-*.iso of=/dev/sdX bs=4M status=progress oflag=sync  # Linux
# or
sudo dd if=dumb-nixos-*.iso of=/dev/rdiskN bs=4m  # macOS (use rdiskN for faster writes)

# 4. Safely eject
sync
sudo eject /dev/sdX  # Linux
# or
diskutil eject /dev/diskN  # macOS
```

**Important Notes:**
- Replace `/dev/sdX` with your actual device (e.g., `/dev/sdb`)
- **Be careful!** Wrong device will destroy data
- Use `lsblk` or `fdisk -l` to confirm device
- Don't use partition numbers (not `/dev/sda1`, use `/dev/sda`)

### Using Ventoy

[Ventoy](https://www.ventoy.net/) allows you to copy ISO directly without reformatting:

1. Install Ventoy to USB drive (one-time setup)
2. Copy ISO file directly to USB drive
3. Boot from Ventoy menu and select ISO

---

## Booting the System

### UEFI Systems

1. Insert USB drive
2. Restart computer
3. Enter firmware setup (usually F2, F10, or DEL during startup)
4. Go to Boot menu
5. Set USB as first boot device
6. If Secure Boot is enabled:
   - The system should boot with shim
   - If it doesn't, you may need to disable Secure Boot or add a boot entry
7. Save and exit
8. System should boot to GRUB menu

### BIOS/Legacy Systems

1. Insert USB drive
2. Restart computer
3. Press boot menu key (usually F12, F11, ESC)
4. Select USB drive from boot menu
5. System should boot to GRUB menu

### Boot Menu Options

The GRUB menu will show:
- **NixOS Live ISO with Tools** - Default boot option
- **NixOS Live ISO with Tools (nomodeset)** - Safe graphics mode
- **NixOS Live ISO with Tools (copytoram)** - Copy system to RAM (needs 4GB+ RAM)

Select with arrow keys and press Enter.

### Troubleshooting Boot Issues

**Black screen after selecting boot option:**
- Use "nomodeset" option
- Try different video output (HDMI/VGA/DisplayPort)

**System hangs during boot:**
- Try "copytoram" option if you have enough RAM
- Check USB drive integrity
- Try a different USB port (USB 2.0 sometimes more compatible)

**UEFI boot not showing:**
- Check if Secure Boot is compatible
- Try disabling Secure Boot temporarily
- Verify ISO was written correctly

---

## Using the Live System

### First Boot Experience

After boot completes:
1. System auto-logs in as user `nixos`
2. XFCE4 desktop appears
3. Network Manager starts (check system tray for network icon)
4. fcitx5 input method starts automatically

### Desktop Layout

- **Panel** (top bar):
  - Applications menu (left)
  - Terminal launcher
  - File manager launcher
  - Web browser launcher
  - System tray (right) - network, volume, notifications
  - Clock

- **Desktop** (middle):
  - Right-click for desktop menu
  - Icons for applications

### Essential Applications

**From Applications Menu:**
- **System Tools**:
  - Terminal
  - File Manager (Thunar)
  - Task Manager
  - System Monitor
  
- **Utilities**:
  - GParted (disk partitioning)
  - GNOME Disks
  - Text Editor
  
- **Internet**:
  - Firefox Web Browser
  - Network Connections

- **Accessories**:
  - Screenshot tool
  - Archive Manager
  - Calculator

### Keyboard Shortcuts

- `Ctrl+Alt+T` - Open terminal
- `Ctrl+Space` - Toggle input method (English ↔ Chinese)
- `Alt+F2` - Run command dialog
- `Ctrl+Alt+Del` - Task Manager
- `PrtSc` - Take screenshot

### Connecting to Internet

**Wired Connection:**
- Should connect automatically
- If not, click network icon → Enable Networking

**WiFi:**
1. Click network icon in system tray
2. Select your WiFi network
3. Enter password
4. Click "Connect"

**Check Connection:**
```bash
ip addr  # Check IP address
ping google.com  # Test internet
```

### Changing Keyboard Layout

```bash
# Temporary change
setxkbmap us  # US layout
setxkbmap gb  # UK layout

# Or use XFCE settings:
# Applications → Settings → Keyboard
```

---

## Advanced Usage

### Remote Access via SSH

SSH server is already running with these credentials:
- Username: `nixos` or `root`
- Password: `nixos`

**From the Live ISO, find IP address:**
```bash
ip addr show
# Look for inet address, e.g., 192.168.1.100
```

**From another computer:**
```bash
ssh nixos@192.168.1.100
# Password: nixos
```

**Enable root login via SSH (if needed):**
```bash
# Already enabled by default
# Settings are in /etc/ssh/sshd_config
```

### Using Multiple Monitors

XFCE should automatically detect multiple monitors.

**Configure displays:**
```bash
xfce4-display-settings
```

Or: Applications → Settings → Display

### Mounting Disks

**Graphical method:**
1. Open Thunar (File Manager)
2. Click on partition in sidebar
3. Will auto-mount to `/run/media/nixos/`

**Command line:**
```bash
# List all disks
lsblk

# Create mount point
sudo mkdir -p /mnt/mydisk

# Mount partition
sudo mount /dev/sda1 /mnt/mydisk

# Mount with specific filesystem
sudo mount -t ntfs-3g /dev/sda1 /mnt/mydisk  # NTFS
sudo mount -t vfat /dev/sda1 /mnt/mydisk     # FAT32

# Unmount
sudo umount /mnt/mydisk
```

### Running as Root

**Open root terminal:**
```bash
sudo -i
```

**Or run single command:**
```bash
sudo command-here
```

No password required (live system configuration).

### Installing Additional Software

The live system uses Nix package manager:

```bash
# Search for packages
nix search nixpkgs package-name

# Install temporarily (session only)
nix-shell -p package-name

# Example: Install python3
nix-shell -p python3
```

**Note:** Installations are temporary and will be lost on reboot.

### Copying Files from Live System

**To USB drive:**
```bash
# Mount USB
sudo mount /dev/sdb1 /mnt/usb

# Copy files
cp /path/to/file /mnt/usb/

# Safely eject
sudo umount /mnt/usb
```

**To network location:**
```bash
# Using SCP
scp file.txt user@remote-host:/path/

# Using rsync
rsync -av /source/ user@remote-host:/destination/
```

**Accessing from other computers:**
- Use SSH (see Remote Access section)
- Or set up temporary file sharing:
```bash
# Simple HTTP server for sharing
cd /path/to/share
python3 -m http.server 8000
# Access from browser: http://192.168.1.100:8000
```

### Persistence Notes

**What persists:**
- Nothing! Live ISO is read-only

**What's lost on reboot:**
- Downloaded files in /home
- Installed packages
- Configuration changes
- Any data not saved to external media

**To preserve data:**
- Save to USB drive
- Upload to cloud storage
- Copy to hard drive partition
- Use SCP/rsync to remote server

---

## Performance Tips

### Slow Boot?
- Use "copytoram" boot option (requires 4GB+ RAM)
- This loads entire ISO to RAM for faster performance

### Low Memory?
- Close unnecessary applications
- Don't use "copytoram" option
- Use lightweight applications only

### Slow Operations?
- Check USB drive speed (USB 3.0 recommended)
- Consider copying ISO to RAM if sufficient memory
- Some operations inherently slow on live systems

---

## Troubleshooting

### Input Method Not Working
```bash
killall fcitx5
fcitx5 &
```

### Display Issues
- Try "nomodeset" boot option
- Check display cable
- Try different video output

### Network Not Working
```bash
# Restart NetworkManager
sudo systemctl restart NetworkManager

# Manual network configuration
sudo ip link set eth0 up
sudo dhclient eth0
```

### Sound Not Working
```bash
# Check volume
alsamixer

# Restart PipeWire
systemctl --user restart pipewire
```

### Can't Mount NTFS
```bash
# Force mount
sudo mount -t ntfs-3g -o remove_hiberfile /dev/sda1 /mnt

# If Windows was hibernated
sudo ntfsfix /dev/sda1
```

---

## Next Steps

After successfully booting the Live ISO, see:
- [README_CN.md](../README_CN.md) - Detailed Chinese documentation
- [TOOLS.md](TOOLS.md) - Complete tool reference
- [QUICKSTART.md](QUICKSTART.md) - Quick reference guide

For specific tasks like Windows password reset, disk cloning, or data recovery, refer to the detailed guides in README_CN.md.
