{ config, lib, pkgs, ... }:
{
  # 网络配置
  networking = {
    hostName = "dumb-nix";
    networkmanager.enable = true;
    wireless.enable = lib.mkForce false;  # NetworkManager 与 wireless 冲突
    # 禁用防火墙以便于在 Live ISO 环境中进行调试和系统维护
    # 注意：这仅适用于 Live ISO，不应用于常规安装
    # 在 Live ISO 中，用户通常需要完全访问网络工具进行诊断
    firewall.enable = false;
  };

  # 启用 SSH
  # 注意：这些设置仅适用于 Live ISO 环境，以便于系统维护和远程访问
  # 对于生产系统，应该使用密钥认证而不是密码认证
  # Live ISO 设计用于临时使用，不存储持久数据
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;  # Live ISO 使用简单密码便于快速访问
    };
  };

  users.users.root = {
    initialHashedPassword = lib.mkForce null;
  };

  # 完全禁用 ISO 镜像默认创建的 nixos 用户
  users.users.nixos = lib.mkForce {
    enable = false;
  };
  
  # 创建默认用户
  users.users.alex = {
    isNormalUser = true;
    password = lib.mkForce "Dumb.n1x";
    shell = pkgs.zsh;
    initialHashedPassword = lib.mkForce null;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    uid = 1000;
  };

  # 允许 wheel 组使用 sudo
  security.sudo.wheelNeedsPassword = false;
}
