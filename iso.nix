{ config, pkgs, lib, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/minimal.nix"
    "${modulesPath}/installer/cd-dvd/installation-cd-base.nix"
    "${modulesPath}/installer/cd-dvd/channel.nix"
    
    # 自定义模块
    ./modules/core
    ./modules/networking
    ./modules/desktop
    ./modules/i18n
    ./modules/hardware
    ./modules/audio
    ./modules/services
    ./modules/packages/essential.nix
    ./modules/packages/network-tools.nix
    ./modules/packages/system-maintenance.nix
    ./modules/packages/recovery-tools.nix
    ./modules/packages/development.nix
    ./modules/packages/xfce-apps.nix
    ./modules/packages/gui-tools.nix
    ./modules/packages/clonezilla.nix
    ./modules/packages/virtualization.nix
  ];

  # ISO 配置
  image = {
    # ISO 文件名
    fileName = lib.mkForce "dumb-nixos-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}.iso";
  };
  
  isoImage = {
    # 通过 shim 支持安全启动
    makeEfiBootable = true;
    makeUsbBootable = true;
    
    # 设置卷标
    volumeID = "DUMB_NIXOS";
    
    # 添加 EFI 引导支持
    appendToMenuLabel = " Live ISO with Tools";
  };

  # 系统配置
  system.stateVersion = "25.11";

  # 设置系统描述
  system.nixos.distroName = "Dumb NixOS";
}
