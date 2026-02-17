{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # VirtualBox Guest Additions
    VirtualBox-GuestAdditions
  ];
}
