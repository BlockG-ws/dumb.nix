{ ... }:
{
  # 启用 kmscon
  services.kmscon.enable = true;

  # 启用蓝牙服务
  services.blueman.enable = true;

  # 配置 Plymouth (启动画面)
  boot.plymouth.enable = true;
}
