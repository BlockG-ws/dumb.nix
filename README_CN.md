# Dumb NixOS - 功能齐全的 Live ISO 系统

[English](README.md) | 简体中文

一个基于 NixOS 的功能强大的 Live ISO 系统，专为系统维护、硬件测试和数据恢复设计。

## ✨ 主要特性

### 🔐 安全启动支持
- 通过 shim 支持 UEFI 安全启动
- 兼容现代主板的安全启动配置
- 同时支持传统 BIOS 和 UEFI 启动

### 🛠️ 硬件测试工具
预装了丰富的硬件测试和诊断工具：
- **系统信息**: `lshw`, `hwinfo`, `dmidecode`, `inxi`
- **性能测试**: `stress`, `stress-ng`, `memtest86plus`
- **硬件监控**: `lm_sensors`, `smartmontools`
- **USB/PCI**: `lsusb`, `lspci`, `usbutils`, `pciutils`
- **磁盘工具**: `hdparm`, `sdparm`, `nvme-cli`

### 💾 磁盘和文件系统支持
支持几乎所有常见的文件系统：
- Linux: ext2/3/4, XFS, Btrfs, ZFS
- Windows: NTFS, FAT32, exFAT
- 其他: UFS, ReiserFS 等

### 🪟 Windows 系统维护
包含强大的 Windows 系统维护工具：
- **密码重置**: `chntpw` - 重置或删除 Windows 用户密码
- **WIM/ESD 处理**: `wimlib` - 处理 Windows 镜像文件
  - 从 WIM/ESD 提取文件
  - 创建或修改系统镜像
  - 部署 Windows 系统
- **NTFS 操作**: `ntfsprogs` - NTFS 文件系统完整工具集
- **引导修复**: `ms-sys` - 修复 Windows MBR 引导

### 💿 备份和恢复
- **Clonezilla**: 完整的磁盘克隆和备份解决方案
  - 支持本地和网络备份
  - 包含 Clonezilla Server 用于批量部署
- **其他工具**: 
  - `partclone` - 分区级别克隆
  - `partimage` - 分区镜像工具
  - `fsarchiver` - 文件系统归档
  - `testdisk` - 数据恢复和分区恢复
  - `ddrescue` - 损坏磁盘数据恢复

### 🌏 中文支持
- 预配置 fcitx5 输入法框架
- 包含中文输入法（拼音、五笔等）
- 预装中文字体（思源黑体、思源宋体、文泉驿等）
- 默认中文界面和本地化设置

### 🖥️ XFCE4 桌面环境
轻量级但功能完整的桌面环境：
- 快速启动和低内存占用
- 完整的文件管理器（Thunar）
- 终端、文本编辑器、截图工具等
- 网络管理器图形界面
- 预配置的优秀用户体验

### 🌐 网络功能
- **SSH 服务器**: 预启用，便于远程访问
- **网络工具**: `nmap`, `tcpdump`, `wireshark`, `mtr`, `iperf3`
- **NetworkManager**: 图形化网络配置
- **支持各种网络协议**: TCP/IP, IPv6, VPN 等

### 🔧 系统维护功能
- **Chroot 支持**: 轻松 chroot 到硬盘上的其他发行版进行修复
- **ZFS 支持**: 完整的 ZFS 文件系统支持
- **引导修复**: GRUB2、EFI 引导管理
- **分区工具**: GParted 图形化分区编辑器

## 📦 安装和使用

### 系统要求
- CPU: x86_64 (64位) 处理器
- 内存: 最低 2GB RAM（推荐 4GB+）
- 存储: USB 驱动器或 DVD（至少 8GB）
- BIOS: 支持 UEFI 或传统 BIOS

### 下载 ISO
从 [Releases](https://github.com/BlockG-ws/dumb.nix/releases) 页面下载最新的 ISO 文件。

### 创建启动盘

#### Windows 用户
使用 [Rufus](https://rufus.ie/) 或 [balenaEtcher](https://www.balena.io/etcher/)：
1. 插入 USB 驱动器
2. 打开 Rufus
3. 选择下载的 ISO 文件
4. 点击"开始"

#### Linux/macOS 用户
使用 `dd` 命令（请确保设备路径正确）：
```bash
# 查找 USB 设备
lsblk

# 写入 ISO（将 /dev/sdX 替换为你的 USB 设备）
sudo dd if=dumb-nixos-*.iso of=/dev/sdX bs=4M status=progress oflag=sync
```

### 启动系统
1. 插入制作好的 USB 驱动器
2. 重启电脑并进入启动菜单（通常是 F12、F2、ESC 或 DEL 键）
3. 选择从 USB 启动
4. 系统将自动启动并登录到 XFCE4 桌面

### 默认登录信息
- **用户名**: `alex`
- **密码**: `Dumb.n1x`

## 🔨 常见使用场景

### 1. 重置 Windows 密码
```bash
# 挂载 Windows 分区
sudo mount /dev/sdaX /mnt

# 查看用户列表
sudo chntpw -l /mnt/Windows/System32/config/SAM

# 重置密码
sudo chntpw -u 用户名 /mnt/Windows/System32/config/SAM
# 按照提示操作，选择 1 清除密码或 2 设置新密码
```

### 2. 从 WIM 文件安装 Windows
```bash
# 挂载 Windows 镜像
sudo mount /path/to/windows.iso /mnt/iso

# 查看 WIM 信息
wiminfo /mnt/iso/sources/install.wim

# 提取指定版本到目标分区（已格式化为 NTFS）
sudo wimapply /mnt/iso/sources/install.wim 1 /mnt/windows

# 修复引导（需要先挂载 EFI 分区）
# 详细步骤请参考 Windows 部署文档
```

### 3. 使用 Clonezilla 备份系统
```bash
# 启动 Clonezilla
sudo clonezilla

# 按照图形界面向导操作：
# 1. 选择设备到镜像或设备到设备
# 2. 选择源磁盘/分区
# 3. 选择目标位置
# 4. 开始备份
```

### 4. Chroot 到现有 Linux 系统
```bash
# 挂载系统分区
sudo mount /dev/sdaX /mnt

# 挂载必要的虚拟文件系统
sudo mount --bind /dev /mnt/dev
sudo mount --bind /proc /mnt/proc
sudo mount --bind /sys /mnt/sys

# 如果是 UEFI 系统，还需要挂载 EFI 分区
sudo mount /dev/sdaY /mnt/boot/efi

# Chroot 进入系统
sudo chroot /mnt /bin/bash

# 现在可以执行修复操作，如：
# - 重装 GRUB：grub-install /dev/sda
# - 更新 initramfs：update-initramfs -u
# - 修改配置文件等

# 完成后退出
exit

# 卸载文件系统
sudo umount -R /mnt
```

### 5. 测试硬件
```bash
# 查看详细硬件信息
sudo lshw -short
sudo hwinfo --short

# CPU 压力测试（10 分钟）
stress-ng --cpu 4 --timeout 600s --metrics

# 内存测试
sudo memtest86plus

# 硬盘 SMART 信息
sudo smartctl -a /dev/sda

# 温度监控
sensors
```

### 6. 网络相关
```bash
# SSH 连接（从其他电脑）
# 先获取 IP 地址
ip addr

# 然后从其他电脑连接
ssh nixos@<IP地址>
# 密码: nixos

# 网络诊断
mtr google.com
nmap -sP 192.168.1.0/24
```

### 7. ZFS 操作
```bash
# 导入 ZFS 池
sudo zpool import

# 导入特定的池
sudo zpool import tank

# 挂载 ZFS 文件系统
sudo zfs mount tank/data

# 查看 ZFS 状态
sudo zpool status
sudo zfs list
```

## 🏗️ 从源码构建

如果你想自定义 ISO 或从源码构建：

### 前置要求
- 安装 Nix 包管理器
- 启用 flakes 实验性功能

### 构建步骤
```bash
# 克隆仓库
git clone https://github.com/BlockG-ws/dumb.nix.git
cd dumb.nix

# 构建 ISO
nix build .#iso

# ISO 文件位于
ls -lh result/iso/*.iso
```

### 自定义配置
编辑 `iso.nix` 文件来自定义：
- 添加或移除软件包
- 修改桌面环境设置
- 调整系统配置
- 更改默认用户和密码

然后重新构建即可。

## 🤝 贡献

欢迎贡献！请随时提交 Issue 或 Pull Request。

### 贡献指南
1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 📝 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件。

## 🙏 致谢

- [NixOS](https://nixos.org/) - 优秀的 Linux 发行版
- [Clonezilla](https://clonezilla.org/) - 强大的备份工具
- [XFCE](https://www.xfce.org/) - 轻量级桌面环境
- 所有开源软件贡献者

## 📞 支持

如有问题或需要帮助：
- 提交 [Issue](https://github.com/BlockG-ws/dumb.nix/issues)
- 查看 [Discussions](https://github.com/BlockG-ws/dumb.nix/discussions)

## ⚠️ 免责声明

本工具仅供合法用途。使用本工具修改系统、重置密码或访问数据时，请确保：
1. 你有合法的权限访问目标系统
2. 你了解操作可能带来的风险
3. 已做好重要数据的备份

作者不对因使用本工具造成的任何数据丢失或系统损坏负责。
