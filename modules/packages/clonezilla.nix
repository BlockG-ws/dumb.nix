{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clonezilla
  ];

  # 创建桌面快捷方式
  environment.etc."skel/.local/share/applications/clonezilla.desktop".text = ''
    [Desktop Entry]
    Version=1.0
    Type=Application
    Name=Clonezilla
    Comment=Disk cloning and imaging solution
    Exec=clonezilla
    Icon=drive-removable-media
    Categories=System;Utility;
    Terminal=true
    StartupNotify=false
  '';
}
