{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # 浏览器
    firefox
    
    # 文本编辑器
    gedit
    
    # 图像查看器
    feh
    
    # PDF 阅读器
    evince
    
    # 归档管理器
    xarchiver
    
    # 计算器
    gnome-calculator  # GNOME 计算器 (去除 gnome. 前缀)
  ];
}
