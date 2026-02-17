{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # 系统工具
    vim
    nano
    wget
    curl
    git
    htop
    btop
    tree
    file
    unzip
    zip
    p7zip
    rar
    unrar
  ];
}
