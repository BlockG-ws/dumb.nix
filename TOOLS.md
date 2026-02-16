# Tool Reference Guide

This document provides a quick reference for the tools included in Dumb NixOS.

## System Information Tools

### `lshw` - List Hardware
```bash
sudo lshw           # Full hardware listing
sudo lshw -short    # Summary format
sudo lshw -c disk   # Only show disks
```

### `hwinfo` - Hardware Information
```bash
sudo hwinfo --short  # Summary
sudo hwinfo --disk   # Disk information
sudo hwinfo --cpu    # CPU information
```

### `inxi` - System Information
```bash
inxi -F              # Full system information
inxi -G              # Graphics information
inxi -D              # Disk information
```

## Hardware Testing

### `stress-ng` - Stress Testing
```bash
# CPU stress test for 60 seconds
stress-ng --cpu 4 --timeout 60s --metrics

# Memory stress test
stress-ng --vm 2 --vm-bytes 1G --timeout 60s

# Disk I/O stress test
stress-ng --hdd 1 --timeout 60s
```

### `smartctl` - SMART Disk Monitoring
```bash
# Check disk health
sudo smartctl -H /dev/sda

# Full SMART info
sudo smartctl -a /dev/sda

# Run short test
sudo smartctl -t short /dev/sda
```

## Disk and Partition Tools

### `gparted` - Graphical Partition Editor
```bash
sudo gparted
```

### `fdisk` - Partition Editor
```bash
sudo fdisk -l        # List all partitions
sudo fdisk /dev/sda  # Edit partition table
```

### `parted` - Partition Tool
```bash
sudo parted /dev/sda print          # Show partitions
sudo parted /dev/sda mklabel gpt    # Create GPT table
```

## Windows System Maintenance

### `chntpw` - Change Windows Password
```bash
# Mount Windows partition
sudo mount /dev/sda2 /mnt

# List users
sudo chntpw -l /mnt/Windows/System32/config/SAM

# Reset password
sudo chntpw -u Administrator /mnt/Windows/System32/config/SAM
# Choose option 1 to clear password or 2 to set new password
```

### `wimlib` - Windows Imaging
```bash
# Display WIM information
wiminfo install.wim

# List images in WIM
wiminfo install.wim --header

# Extract specific image (image 1)
sudo wimapply install.wim 1 /mnt/target

# Extract specific files
wimextract install.wim 1 /Windows/System32/cmd.exe --dest-dir=/tmp

# Create WIM from directory
wimcapture /mnt/source image.wim "Windows Backup"
```

### NTFS Tools
```bash
# Check NTFS filesystem
sudo ntfsfix /dev/sda1

# Resize NTFS
sudo ntfsresize --info /dev/sda1
sudo ntfsresize --size 50G /dev/sda1

# Clone NTFS partition
sudo ntfsclone --save-image -o image.img /dev/sda1
```

## Backup and Recovery

### `clonezilla` - Disk Cloning
```bash
# Start Clonezilla
sudo clonezilla

# Follow the text-based menu:
# 1. device-image: backup/restore to/from image
# 2. device-device: clone disk to disk
# 3. Select source and destination
```

### `testdisk` - Data Recovery
```bash
# Start TestDisk
sudo testdisk

# Steps:
# 1. Select disk
# 2. Select partition table type
# 3. Analyse to find lost partitions
# 4. Quick Search or Deeper Search
# 5. Write changes if needed
```

### `photorec` - File Recovery
```bash
# Start PhotoRec (comes with testdisk)
sudo photorec

# Select disk and partition
# Choose file types to recover
# Select destination for recovered files
```

### `ddrescue` - Data Recovery from Damaged Disks
```bash
# Clone disk with error recovery
sudo ddrescue /dev/sda /dev/sdb rescue.log

# Try to fill in gaps from previous run
sudo ddrescue -r 3 /dev/sda /dev/sdb rescue.log
```

## ZFS Operations

### Basic ZFS Commands
```bash
# Import all pools
sudo zpool import

# Import specific pool
sudo zpool import tank

# Check pool status
sudo zpool status

# List ZFS filesystems
sudo zfs list

# Mount ZFS filesystem
sudo zfs mount tank/data

# Create snapshot
sudo zfs snapshot tank/data@backup

# List snapshots
sudo zfs list -t snapshot
```

## Network Tools

### `nmap` - Network Scanner
```bash
# Scan network
nmap -sP 192.168.1.0/24

# Port scan
nmap -p 1-1000 192.168.1.1

# OS detection
sudo nmap -O 192.168.1.1
```

### `tcpdump` - Packet Analyzer
```bash
# Capture packets
sudo tcpdump -i eth0

# Capture to file
sudo tcpdump -i eth0 -w capture.pcap

# Read from file
tcpdump -r capture.pcap
```

### `wireshark` - Graphical Packet Analyzer
```bash
sudo wireshark
```

### `iperf3` - Network Bandwidth Testing
```bash
# Server mode
iperf3 -s

# Client mode (on another machine)
iperf3 -c <server-ip>
```

## SSH Access

### Enable and Use SSH
```bash
# SSH is already enabled by default

# Get IP address
ip addr

# From another machine:
ssh nixos@<ip-address>
# Password: nixos
```

## Chroot to Installed Systems

### Chroot to Linux System
```bash
# Mount root partition
sudo mount /dev/sda1 /mnt

# Mount virtual filesystems
sudo mount --bind /dev /mnt/dev
sudo mount --bind /proc /mnt/proc
sudo mount --bind /sys /mnt/sys

# If UEFI system
sudo mount /dev/sda2 /mnt/boot/efi

# Chroot
sudo chroot /mnt /bin/bash

# Do your repairs...
# Examples:
# - grub-install /dev/sda
# - update-grub
# - passwd username

# Exit chroot
exit

# Unmount
sudo umount -R /mnt
```

## Boot Repair

### GRUB Repair
```bash
# After chrooting to system
sudo grub-install /dev/sda
sudo update-grub

# Or for UEFI
sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi
```

### EFI Boot Management
```bash
# List boot entries
sudo efibootmgr

# Create new boot entry
sudo efibootmgr -c -d /dev/sda -p 1 -L "Linux" -l '\EFI\linux\grubx64.efi'

# Change boot order
sudo efibootmgr -o 0001,0000,0002

# Delete boot entry
sudo efibootmgr -b 0003 -B
```

## Input Method (fcitx5)

### Switch Input Method
- Default: `Ctrl+Space` switches between English and Chinese input

### Configure fcitx5
```bash
fcitx5-configtool
```

## File Operations

### Archive Tools
```bash
# Extract various formats
tar -xzf file.tar.gz
tar -xjf file.tar.bz2
unzip file.zip
7z x file.7z
unrar x file.rar

# Create archives
tar -czf backup.tar.gz /path/to/dir
zip -r backup.zip /path/to/dir
```

## Additional Tips

### Mount ISO Files
```bash
sudo mount -o loop image.iso /mnt
```

### Create Disk Image
```bash
# Full disk image
sudo dd if=/dev/sda of=disk.img bs=4M status=progress

# Compressed image
sudo dd if=/dev/sda bs=4M | gzip > disk.img.gz
```

### Secure Erase Disk
```bash
# CAUTION: This will destroy all data!
sudo dd if=/dev/zero of=/dev/sda bs=4M status=progress
```

For more detailed information, use the `man` command:
```bash
man <command-name>
```

Or get help:
```bash
<command-name> --help
```
