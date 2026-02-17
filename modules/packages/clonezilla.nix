{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clonezilla
  ];

  # 创建桌面快捷方式
  environment.etc."skel/.local/share/applications/clonezilla.desktop".source = ../../config/clonezilla/clonezilla.desktop ;
}
