{ ... }:

{
  imports = [
    ./hardware.nix
    ./network.nix
    ./nftable.nix
    ./pppoe.nix
  ];

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;
    "net.ipv6.conf.all.forwarding" = true;
  };
}
