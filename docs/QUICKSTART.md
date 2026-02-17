# Quick Start Guide / 快速入门指南

[English](#english) | [中文](#中文)

---

## English

### Download and Boot

1. **Download the ISO**
   - Go to [Releases](https://github.com/BlockG-ws/dumb.nix/releases)
   - Download the latest `dumb-nixos-*.iso` file

2. **Create Bootable USB**
   - **Windows**: Use [Rufus](https://rufus.ie/)
   - **Linux/Mac**: Use `dd` command
   ```bash
   sudo dd if=dumb-nixos-*.iso of=/dev/sdX bs=4M status=progress
   ```

3. **Boot from USB**
   - Restart computer
   - Press F12/F2/ESC/DEL to enter boot menu
   - Select USB drive
   - Wait for system to boot (auto-login enabled)

### First Steps After Boot

The system will automatically:
- ✅ Login as user `nixos`
- ✅ Start XFCE4 desktop
- ✅ Enable WiFi/Ethernet
- ✅ Start fcitx5 input method

**Login Credentials:**
- Username: `nixos` or `root`
- Password: `nixos`

### Common Tasks

#### 1. Connect to WiFi
Click network icon in taskbar → Select network → Enter password

#### 2. Switch Input Method
Press `Ctrl + Space` to toggle between English and Chinese input

#### 3. Open Terminal
Click terminal icon in taskbar or press `Ctrl+Alt+T`

#### 4. Access via SSH
```bash
# On the Live ISO, check IP address:
ip addr

# From another computer:
ssh nixos@<ip-address>
# Password: nixos
```

#### 5. Reset Windows Password
See detailed guide in [README_CN.md](../README_CN.md#1-重置-windows-密码)

#### 6. Backup with Clonezilla
```bash
sudo clonezilla
```
Follow the on-screen wizard

### Need Help?

- 📖 [Full Documentation](../README.md)
- 🛠️ [Tool Reference](TOOLS.md)
- 🇨🇳 [中文文档](../README_CN.md)
- 💬 [Issues](https://github.com/BlockG-ws/dumb.nix/issues)

---

## 中文

### 下载和启动

1. **下载 ISO 镜像**
   - 访问 [Releases](https://github.com/BlockG-ws/dumb.nix/releases)
   - 下载最新的 `dumb-nixos-*.iso` 文件

2. **制作启动盘**
   - **Windows**: 使用 [Rufus](https://rufus.ie/)
   - **Linux/Mac**: 使用 `dd` 命令
   ```bash
   sudo dd if=dumb-nixos-*.iso of=/dev/sdX bs=4M status=progress
   ```

3. **从 USB 启动**
   - 重启电脑
   - 按 F12/F2/ESC/DEL 进入启动菜单
   - 选择 USB 驱动器
   - 等待系统启动（自动登录已启用）

### 启动后的第一步

系统会自动：
- ✅ 以用户 `nixos` 登录
- ✅ 启动 XFCE4 桌面环境
- ✅ 启用 WiFi/有线网络
- ✅ 启动 fcitx5 输入法

**登录凭据：**
- 用户名：`nixos` 或 `root`
- 密码：`nixos`

### 常见任务

#### 1. 连接 WiFi
点击任务栏中的网络图标 → 选择网络 → 输入密码

#### 2. 切换输入法
按 `Ctrl + Space` 在中英文输入之间切换

#### 3. 打开终端
点击任务栏中的终端图标或按 `Ctrl+Alt+T`

#### 4. 通过 SSH 访问
```bash
# 在 Live ISO 上，查看 IP 地址：
ip addr

# 从另一台电脑连接：
ssh nixos@<IP地址>
# 密码：nixos
```

#### 5. 重置 Windows 密码
查看 [README_CN.md](../README_CN.md#1-重置-windows-密码) 中的详细指南

#### 6. 使用 Clonezilla 备份
```bash
sudo clonezilla
```
按照屏幕向导操作

### 需要帮助？

- 📖 [完整文档](../README_CN.md)
- 🛠️ [工具参考](TOOLS.md)
- 🇬🇧 [English Docs](../README.md)
- 💬 [问题反馈](https://github.com/BlockG-ws/dumb.nix/issues)

---

## Troubleshooting / 故障排除

### Boot Issues / 启动问题

**Problem**: System won't boot from USB
**问题**：无法从 USB 启动

**Solution** / **解决方案**:
- Check if Secure Boot is properly configured
- Try different USB ports (USB 2.0 sometimes works better)
- Recreate the USB drive
- 检查安全启动配置
- 尝试不同的 USB 接口（USB 2.0 有时更稳定）
- 重新制作启动盘

### Display Issues / 显示问题

**Problem**: Black screen or no display
**问题**：黑屏或无显示

**Solution** / **解决方案**:
- Add boot parameter: `nomodeset`
- Try different display output (HDMI/DisplayPort/VGA)
- 添加启动参数：`nomodeset`
- 尝试不同的显示输出接口

### Network Issues / 网络问题

**Problem**: WiFi not working
**问题**：WiFi 无法工作

**Solution** / **解决方案**:
- Some WiFi cards may need additional firmware
- Use Ethernet connection as alternative
- Check if WiFi hardware switch is enabled
- 某些 WiFi 网卡可能需要额外的固件
- 使用有线网络作为替代
- 检查 WiFi 硬件开关是否已启用

### Input Method Issues / 输入法问题

**Problem**: fcitx5 not working
**问题**：fcitx5 无法工作

**Solution** / **解决方案**:
```bash
# Restart fcitx5
killall fcitx5
fcitx5 &
```

---

## Build from Source / 从源码构建

If you want to customize the ISO:
如果你想自定义 ISO：

```bash
# Clone repository / 克隆仓库
git clone https://github.com/BlockG-ws/dumb.nix.git
cd dumb.nix

# Edit configuration / 编辑配置
nano iso.nix

# Build (requires Nix) / 构建（需要 Nix）
./build.sh
```

See [CONTRIBUTING.md](../CONTRIBUTING.md) for detailed development guide.
查看 [CONTRIBUTING.md](../CONTRIBUTING.md) 了解详细的开发指南。
