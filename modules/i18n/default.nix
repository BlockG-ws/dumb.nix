{ pkgs, ... }:
{
  # 配置 fcitx5 输入法
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-configtool
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

  # 字体配置
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      wqy_zenhei
      wqy_microhei
      source-han-sans
      source-han-serif
    ];
    
    fontconfig = {
      defaultFonts = {
        monospace = [ "Noto Sans Mono CJK SC" ];
        sansSerif = [ "Noto Sans CJK SC" ];
        serif = [ "Noto Serif CJK SC" ];
      };
    };
  };

  # 时区设置
  time.timeZone = "Asia/Shanghai";

  # 配置环境变量
  environment.sessionVariables = {
    # fcitx5 环境变量
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
  };

  # 自动启动 fcitx5
  environment.etc."xdg/autostart/fcitx5.desktop".source = ../../../config/fcitx5/fcitx5.desktop;

  # 预置 fcitx5 配置文件
  environment.etc."skel/.config/fcitx5/config".source = ../../../config/fcitx5/config;
  environment.etc."skel/.config/fcitx5/profile".source = ../../../config/fcitx5/profile;
}
