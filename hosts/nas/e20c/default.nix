{ ... }:

{
  imports = [
    ./adguardhome.nix
    ./hardware.nix
    ./network.nix
    ./nftable.nix
    ./sing-box.nix
  ];

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;
    "net.ipv6.conf.all.forwarding" = true;
  };
}
