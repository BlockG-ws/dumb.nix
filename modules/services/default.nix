{ ... }:
{
  # 启用打印服务
  services.printing.enable = true;

  # 启用蓝牙服务
  services.blueman.enable = true;

  # 配置 Plymouth (启动画面)
  boot.plymouth.enable = true;
}
