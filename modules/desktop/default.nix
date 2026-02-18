{ config, lib, pkgs, ... }:
lib.mkMerge [
  (import ./fonts.nix { inherit pkgs; })
  {
    # 启用 XFCE4 桌面环境
    services.xserver = {
      enable = true;

      desktopManager.xfce = {
        enable = true;
      };

      displayManager = {
        lightdm.enable = true;
      };
    };

    # 自动登录配置（已移至 services.displayManager）
    services.displayManager.autoLogin = {
      enable = true;
      user = "alex";
    };

    # 启用触摸板支持（已移至 services.libinput）
    services.libinput.enable = true;

    # 启用 GVfs 以支持 Thunar 挂载
    services.gvfs.enable = true;

    # 启用 udisks2
    services.udisks2.enable = true;

    # 启用 dbus
    services.dbus.enable = true;
  }
]
