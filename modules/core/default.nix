{ ... }:
{
  # 全局系统设置

  # 文档
  documentation = {
    enable = true;
    man.enable = true;
    info.enable = true;
  };

  # Nix 配置
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    
    # 清理旧的包
    gc = {
      automatic = false;
    };
  };
}
