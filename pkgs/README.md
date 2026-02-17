# 自定义软件包

这个目录包含了 Dumb NixOS 项目的自定义软件包定义。

## 目录结构

每个软件包都有自己的子目录，包含：
- `<包名>.nix` - Nix 包定义文件
- 相关的补丁文件（如 `*.patch`）
- 其他包特定的资源文件

```
pkgs/
├── default.nix          # 包集合入口文件
├── README.md            # 本文件
├── drbl/                # DRBL - Diskless Remote Boot in Linux
│   ├── drbl.nix
│   └── usrbin.patch
└── clonezilla/          # Clonezilla - 磁盘克隆工具
    ├── clonezilla.nix
    └── usrbin.patch
```

## 包列表

### 系统恢复工具

- **drbl** (v5.8.1) - Diskless Remote Boot in Linux
  - 提供无盘启动环境管理
  - 用于大规模系统部署
  
- **clonezilla** (v5.14.5) - 分区和磁盘克隆工具
  - 类似 Norton Ghost 的开源替代品
  - 基于 DRBL、Partclone 和 udpcast

## 使用方法

在 `flake.nix` 中通过 overlay 引用：

```nix
overlays = [
  (final: prev: {
    drbl = final.callPackage ./pkgs/drbl/drbl.nix { };
    clonezilla = final.callPackage ./pkgs/clonezilla/clonezilla.nix { };
  })
];
```

或者使用 `default.nix`：

```nix
let
  customPkgs = import ./pkgs { inherit pkgs; };
in
{
  environment.systemPackages = with customPkgs; [
    drbl
    clonezilla
  ];
}
```

## 添加新包

1. 在 `pkgs/` 下创建新的子目录，命名为包名
2. 在子目录中创建 `<包名>.nix` 文件
3. 将相关补丁和资源文件放在同一目录
4. 在 `default.nix` 中添加新包的引用
5. 在 `flake.nix` 的 overlay 中添加新包

## 参考

- DRBL 项目：https://drbl.org/
- Clonezilla 项目：https://clonezilla.org/
