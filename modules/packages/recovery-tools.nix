{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Windows 系统维护工具
    chntpw          # Windows 密码修改
    wimlib          # WIM/ESD 文件处理
    ntfsprogs       # NTFS 工具
    ms-sys          # 修复 Windows 引导
    
    # Clonezilla 相关工具 (注：clonezilla 本身不作为 nixpkgs 包提供)
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
  ];
}
