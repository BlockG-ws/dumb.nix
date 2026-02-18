{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clonezilla
  ];

  environment.etc."drbl/drbl.conf".source = ../../config/drbl/drbl.conf;
}
