# Project Structure / 项目结构

This document explains the structure and purpose of each file in the Dumb NixOS project.

## Core Configuration Files / 核心配置文件

### `iso.nix`
The main NixOS configuration file that defines the Live ISO system.

**Key sections:**
- ISO image configuration (boot settings, volume labels)
- System settings (locale, timezone, users)
- Network configuration (NetworkManager, SSH)
- Desktop environment (XFCE4, auto-login)
- Input method (fcitx5 with Chinese support)
- Hardware support (drivers, firmware, microcode)
- System packages (tools, utilities, applications)

**Features configured:**
- Secure boot support via shim
- Auto-login as user "nixos"
- SSH server with password authentication
- Complete driver and firmware support
- ZFS filesystem support
- Pre-installed system maintenance tools

### `flake.nix`
Modern Nix flake configuration for reproducible builds.

**Purpose:**
- Defines project inputs (nixpkgs)
- Declares NixOS configuration
- Provides build outputs (ISO image)
- Enables `nix build .#iso` command

**Benefits:**
- Reproducible builds
- Pin dependencies
- Easy to share and distribute
- Modern Nix workflow

## Configuration Directories / 配置目录

### `config/`
Contains pre-configured settings files.

#### `config/fcitx5/config`
fcitx5 input method main configuration.
- Sets Ctrl+Space as trigger key
- Configures input method behavior

#### `config/fcitx5/profile`
fcitx5 input method profile.
- Defines default input method group
- Sets pinyin as default Chinese input

## Build and Development / 构建和开发

### `build.sh`
Shell script for building the ISO locally.

**Features:**
- Checks for Nix installation
- Builds the ISO with flakes
- Displays ISO information
- Shows SHA256 checksum
- Provides usage instructions

**Usage:**
```bash
./build.sh
```

### `.gitignore`
Specifies intentionally untracked files.

**Ignores:**
- Nix build outputs (result, result-*)
- ISO and image files
- IDE configuration
- Temporary files
- Log files

### `.gitattributes`
Git attributes for consistent line endings.

**Settings:**
- Text files use LF (Unix) line endings
- Binary files (ISO, IMG) are marked as binary
- Ensures consistency across platforms

## Documentation / 文档

### `README.md` (English)
Main project documentation in English.

**Contents:**
- Feature overview
- Installation instructions
- Usage examples
- Build from source guide
- Contributing information

### `README_CN.md` (Chinese / 中文)
Complete documentation in Chinese.

**Contents:**
- 详细的功能说明
- 安装和使用指南
- 常见使用场景
- 工具使用示例
- 故障排除

### `QUICKSTART.md`
Quick reference guide in both languages.

**Contents:**
- Fast-track getting started
- Common tasks
- Login credentials
- Quick troubleshooting
- Links to detailed docs

### `INSTALL.md`
Detailed installation and usage guide.

**Contents:**
- Creating bootable media (Rufus, Etcher, dd)
- Booting the system (UEFI, BIOS)
- First boot experience
- Desktop layout and shortcuts
- Advanced usage (SSH, mounting, etc.)
- Troubleshooting

### `TOOLS.md`
Comprehensive tool reference.

**Contents:**
- System information tools
- Hardware testing commands
- Disk and partition tools
- Windows maintenance tools
- Backup and recovery tools
- Network tools
- Usage examples for each tool

### `CONTRIBUTING.md`
Guidelines for contributing to the project.

**Contents:**
- How to report issues
- How to submit changes
- Code style guidelines
- Testing requirements
- Pull request process

### `CHANGELOG.md`
Project changelog following Keep a Changelog format.

**Contents:**
- Version history
- New features
- Bug fixes
- Security updates
- Breaking changes

## GitHub Configuration / GitHub 配置

### `.github/workflows/build.yml`
GitHub Actions workflow for automated building.

**Triggers:**
- Push to main/master branch
- New tags (v*)
- Pull requests
- Manual workflow dispatch

**Steps:**
1. Checkout code
2. Install Nix with flakes
3. Setup Cachix (optional)
4. Build ISO
5. Upload artifact
6. Create release (for tags)

**Outputs:**
- ISO file as artifact (30-day retention)
- GitHub release with ISO and checksums (for tags)

### `.github/ISSUE_TEMPLATE/bug_report.yml`
Bug report template for users.

**Fields:**
- Description / 问题描述
- Steps to reproduce / 重现步骤
- Expected vs actual behavior / 期望与实际行为
- ISO version / ISO 版本
- Boot mode / 启动模式
- Hardware information / 硬件信息
- Error logs / 错误日志

### `.github/ISSUE_TEMPLATE/feature_request.yml`
Feature request template.

**Fields:**
- Problem description / 问题描述
- Proposed solution / 建议的解决方案
- Alternatives / 替代方案
- Category / 类别
- Additional context / 额外信息

### `.github/pull_request_template.md`
Pull request template.

**Sections:**
- Description / 描述
- Type of change / 更改类型
- Changes made / 所做更改
- Testing / 测试
- Checklist / 检查清单
- Screenshots / 截图

## License / 许可证

### `LICENSE`
MIT License - permissive open source license.

**Permissions:**
- Commercial use
- Modification
- Distribution
- Private use

**Conditions:**
- License and copyright notice

## File Organization Summary / 文件组织总结

```
dumb.nix/
├── Configuration / 配置
│   ├── iso.nix                    # Main NixOS configuration
│   ├── flake.nix                  # Flake configuration
│   └── config/                    # Pre-configured settings
│       └── fcitx5/               # Input method config
│
├── Documentation / 文档
│   ├── README.md                  # English documentation
│   ├── README_CN.md               # Chinese documentation
│   ├── QUICKSTART.md              # Quick start guide
│   ├── INSTALL.md                 # Installation guide
│   ├── TOOLS.md                   # Tool reference
│   ├── CONTRIBUTING.md            # Contributing guide
│   ├── CHANGELOG.md               # Version history
│   └── PROJECT_STRUCTURE.md       # This file
│
├── Build Tools / 构建工具
│   └── build.sh                   # Build script
│
├── GitHub / GitHub 配置
│   └── .github/
│       ├── workflows/
│       │   └── build.yml          # CI/CD workflow
│       ├── ISSUE_TEMPLATE/        # Issue templates
│       └── pull_request_template.md
│
└── Git Configuration / Git 配置
    ├── .gitignore                 # Ignored files
    └── .gitattributes             # File attributes
```

## Key Design Decisions / 关键设计决策

### 1. Security in Live ISO Context
**Decision:** Allow password authentication and root SSH login.

**Rationale:**
- Live ISOs are temporary and don't store persistent data
- Easy access is crucial for system rescue scenarios
- Users need quick remote access for maintenance
- All data is lost on reboot anyway

**Mitigation:**
- Clear documentation of security implications
- Warnings in configuration comments
- Not recommended for regular installations

### 2. Comprehensive Tool Set
**Decision:** Include extensive system maintenance and recovery tools.

**Rationale:**
- Target users: system administrators and technicians
- Use case: system rescue and maintenance
- Minimize need for additional downloads
- Enable offline system repair

**Trade-offs:**
- Larger ISO size (but acceptable for 8GB+ USB drives)
- Longer build time (but only once for ISO creation)

### 3. Chinese Language First
**Decision:** Default to Chinese locale with fcitx5.

**Rationale:**
- Primary target audience in China
- Better user experience for Chinese users
- Still fully accessible for English users

### 4. XFCE4 Desktop
**Decision:** Use XFCE4 instead of GNOME or KDE.

**Rationale:**
- Lightweight and fast
- Lower RAM requirements
- Familiar interface
- Good balance of features and performance

### 5. Flakes-Based Build
**Decision:** Use Nix flakes for configuration.

**Rationale:**
- Modern Nix workflow
- Reproducible builds
- Better dependency management
- Easier to maintain long-term

## Future Considerations / 未来考虑

- Add more language support
- Include additional recovery tools as they become available
- Optimize ISO size if needed
- Add more hardware-specific configurations
- Create specialized variants (minimal, full, server)

## Getting Help / 获取帮助

- **Issues:** Report bugs or request features
- **Discussions:** Ask questions or share ideas
- **Documentation:** Refer to README files
- **Community:** Connect with other users

## Version Information / 版本信息

This documentation reflects the initial release structure.
For updates, see CHANGELOG.md.

---

*Last updated: Initial Release*
