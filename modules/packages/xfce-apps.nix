{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # 文件浏览器和编辑器
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.xfce4-terminal
    xfce.mousepad
    
    # 其他 XFCE 组件
    xfce.xfce4-appfinder
    xfce.xfce4-panel
    xfce.xfce4-session
    xfce.xfce4-settings
    xfce.xfce4-power-manager
    xfce.xfce4-screenshooter
    xfce.xfce4-taskmanager
    xfce.xfce4-clipman-plugin
    
    # 输入法相关
    fcitx5
    fcitx5-chinese-addons
    fcitx5-configtool
    fcitx5-gtk
  ];
}
