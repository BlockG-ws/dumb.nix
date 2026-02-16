{ config, pkgs, lib, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    "${modulesPath}/installer/cd-dvd/channel.nix"
  ];

  # ISO 配置
  isoImage = {
    # ISO 文件名
    isoName = lib.mkForce "dumb-nixos-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}.iso";
    
    # 通过 shim 支持安全启动
    makeEfiBootable = true;
    makeUsbBootable = true;
    
    # 设置卷标
    volumeID = "DUMB_NIXOS";
    
    # 添加 EFI 引导支持
    appendToMenuLabel = " Live ISO with Tools";
  };

  # 系统配置
  system.stateVersion = "24.05";

  # 网络配置
  networking = {
    hostName = "dumb-nixos";
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
      PermitRootLogin = "yes";  # Live ISO 允许 root 登录以便于系统维护
      PasswordAuthentication = true;  # Live ISO 使用简单密码便于快速访问
    };
  };

  # 设置 root 密码为 "nixos"
  users.users.root.password = "nixos";

  # 创建默认用户
  users.users.nixos = {
    isNormalUser = true;
    password = "nixos";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    uid = 1000;
  };

  # 允许 wheel 组使用 sudo
  security.sudo.wheelNeedsPassword = false;

  # 启用 XFCE4 桌面环境
  services.xserver = {
    enable = true;
    
    desktopManager.xfce = {
      enable = true;
      enableXfwm = true;
      noDesktop = false;
    };
    
    displayManager = {
      lightdm.enable = true;
      autoLogin = {
        enable = true;
        user = "nixos";
      };
    };
    
    # 启用触摸板支持
    libinput.enable = true;
  };

  # 配置 fcitx5 输入法
  i18n.inputMethod = {
    enabled = "fcitx5";
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

  # 启用 ZFS 支持
  boot.supportedFilesystems = [ "zfs" "btrfs" "xfs" "ext4" "ntfs" "vfat" ];
  # 对于用于救援/安装的 Live ISO，使用稳定的 ZFS 模块以提高可靠性
  boot.zfs.enableUnstable = false;
  
  # 内核模块和固件
  boot.kernelModules = [ "kvm-intel" "kvm-amd" ];
  
  # 包含几乎所有驱动
  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    
    # CPU 微码
    cpu.intel.updateMicrocode = true;
    cpu.amd.updateMicrocode = true;
    
    # OpenGL/显卡支持
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        intel-media-driver
        vaapiIntel
      ];
    };
    
    # 蓝牙
    bluetooth.enable = true;
    
    # 声音
    pulseaudio.enable = false;
  };

  # 使用 PipeWire 替代 PulseAudio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # 启用打印服务
  services.printing.enable = true;

  # 启用蓝牙服务
  services.blueman.enable = true;

  # 系统包
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
    
    # 网络工具
    networkmanagerapplet
    inetutils
    dnsutils
    nmap
    tcpdump
    wireshark
    ethtool
    iperf3
    mtr
    traceroute
    
    # 磁盘工具
    gparted
    gnome.gnome-disk-utility
    smartmontools
    hdparm
    sdparm
    nvme-cli
    
    # 文件系统工具
    e2fsprogs
    dosfstools
    ntfs3g
    exfat
    btrfs-progs
    xfsprogs
    zfs
    
    # 硬件信息和测试工具
    lshw
    pciutils
    usbutils
    dmidecode
    lm_sensors
    hwinfo
    inxi
    stress
    stress-ng
    memtest86plus
    
    # Windows 系统维护工具
    chntpw          # Windows 密码修改
    wimlib          # WIM/ESD 文件处理
    ntfsprogs       # NTFS 工具
    ms-sys          # 修复 Windows 引导
    
    # Clonezilla 和相关工具
    clonezilla
    partclone
    partimage
    fsarchiver
    
    # 数据恢复工具
    testdisk       # 包含 photorec 数据恢复工具
    ddrescue
    
    # 引导修复工具
    grub2
    efibootmgr
    efivar
    
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
    
    # 文件浏览器和编辑器
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.xfce4-terminal
    mousepad
    
    # 浏览器
    firefox
    
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
    
    # 文本编辑器
    gedit
    
    # 图像查看器
    feh
    
    # PDF 阅读器
    evince
    
    # 归档管理器
    xarchiver
    
    # 计算器
    gnome.gnome-calculator
  ];

  # 启用 GVfs 以支持 Thunar 挂载
  services.gvfs.enable = true;

  # 启用 udisks2
  services.udisks2.enable = true;

  # 启用 dbus
  services.dbus.enable = true;

  # 配置环境变量
  environment.variables = {
    # fcitx5 环境变量
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "fcitx";
  };

  # 自动启动 fcitx5
  environment.etc."xdg/autostart/fcitx5.desktop".text = ''
    [Desktop Entry]
    Name=Fcitx 5
    GenericName=Input Method
    Comment=Start Fcitx 5
    Exec=fcitx5
    Icon=fcitx
    Terminal=false
    Type=Application
    Categories=System;Utility;
    StartupNotify=false
    X-GNOME-Autostart-Phase=Applications
    X-GNOME-AutoRestart=true
    X-GNOME-Autostart-Notify=false
    X-KDE-autostart-after=panel
  '';

  # 预置 fcitx5 配置文件
  environment.etc."skel/.config/fcitx5/config".source = ./config/fcitx5/config;
  environment.etc."skel/.config/fcitx5/profile".source = ./config/fcitx5/profile;

  # 配置 Plymouth (启动画面)
  boot.plymouth.enable = true;

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

  # 文档
  documentation = {
    enable = true;
    man.enable = true;
    info.enable = true;
  };

  # 允许非自由软件
  nixpkgs.config.allowUnfree = true;

  # 设置系统描述
  system.nixos.distroName = "Dumb NixOS";
}
