{ ... }:

{
  imports = [
    ./adguardhome.nix
    ./einat.nix
    ./hardware.nix
    ./network.nix
    ./nftable.nix
    ./others.nix
    ./sing-box
  ];

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;
    "net.ipv6.conf.all.forwarding" = true;
  };
}
