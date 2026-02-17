{ pkgs, ... }:
{
  # 使用最新的内核
  boot.kernelPackages = pkgs.linuxPackages;
  
  # 启用 ZFS 支持
  boot.supportedFilesystems = [ "zfs" "btrfs" "xfs" "ext4" "ntfs" "vfat" ];
  
  # 内核模块和固件
  boot.kernelModules = [ "kvm-intel" "kvm-amd" ];
  
  # 包含驱动和固件
  hardware = {
    enableRedistributableFirmware = true;
    
    # CPU 微码
    cpu.intel.updateMicrocode = true;
    cpu.amd.updateMicrocode = true;
    
    # GPU 支持 (取代之前的 opengl)
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        libva-vdpau-driver
        libvdpau-va-gl
        intel-media-driver  # 新版 Intel GPU (Broadwell+)
        intel-vaapi-driver  # 旧版 Intel GPU (替代 vaapiIntel)
      ];
    };
    
    # 蓝牙
    bluetooth.enable = true;
  };
  
  # 声音设置（已移至 services.pulseaudio）
  services.pulseaudio.enable = false;
}
