{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # 磁盘工具
    gparted
    gnome.gnome-disk-utility
    smartmontools
    hdparm
    sdparm
    nvme-cli
    
    # 文件系统工具
    e2fsprogs
    dosfstools
    ntfs3g
    exfat
    btrfs-progs
    xfsprogs
    zfs
    
    # 硬件信息和测试工具
    lshw
    pciutils
    usbutils
    dmidecode
    lm_sensors
    hwinfo
    inxi
    stress
    stress-ng
    memtest86plus
  ];
}
