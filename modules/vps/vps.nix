{ ... }:

{
  zenith.podman.traffmonetizer.enable = true;

  networking.nameservers = [
    "2606:4700:4700::1111"
    "1.1.1.1"
  ];
}
