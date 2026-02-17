{ lib, ... }:
let
  # 获取当前目录中所有 .nix 文件（排除 default.nix）
  nixFiles = builtins.filter
    (name: name != "default.nix" && lib.hasSuffix ".nix" name)
    (builtins.attrNames (builtins.readDir ./.));

  # 将文件名转换为导入路径
  imports = map (name: ./. + "/${name}") nixFiles;
in
{
  inherit imports;
}


