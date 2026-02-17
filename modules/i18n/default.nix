{ pkgs, ... }:
{
  # 配置 fcitx5 输入法
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons  # 已移至 qt6Packages
      qt6Packages.fcitx5-configtool      # 已移至 qt6Packages
      fcitx5-gtk
    ];
  };

  # 设置中文支持
  i18n.defaultLocale = "zh_CN.UTF-8";
  
  i18n.extraLocaleSettings = {
    LC_TIME = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
  };

  # 时区设置
  time.timeZone = "Asia/Shanghai";

  # 自动启动 fcitx5
  environment.etc."xdg/autostart/fcitx5.desktop".source = ../../config/fcitx5/fcitx5.desktop;

  # 预置 fcitx5 配置文件
  environment.etc."skel/.config/fcitx5/config".source = ../../config/fcitx5/config;
  environment.etc."skel/.config/fcitx5/profile".source = ../../config/fcitx5/profile;
}
