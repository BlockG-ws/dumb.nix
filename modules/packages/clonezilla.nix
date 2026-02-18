{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clonezilla
  ];
}
