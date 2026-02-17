# 自定义包集合
{ pkgs }:

{
  # 系统恢复工具
  drbl = pkgs.callPackage ./drbl/drbl.nix { };
  clonezilla = pkgs.callPackage ./clonezilla/clonezilla.nix { };
}
