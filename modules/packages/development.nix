{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # 开发和调试工具
    gcc
    gnumake
    binutils
    gdb
    strace
    ltrace
    
    # 系统管理
    tmux
    screen
    rsync
    rclone
  ];
}
