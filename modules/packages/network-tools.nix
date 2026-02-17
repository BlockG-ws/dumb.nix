{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # 网络工具
    networkmanagerapplet
    inetutils
    dnsutils
    nmap
    tcpdump
    wireshark
    ethtool
    iperf3
    mtr
    traceroute
  ];
}
