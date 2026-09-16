{ ... }:

{
  zenith.podman.traffmonetizer.enable = true;

  services.endlessh-go = {
    enable = true;
    port = 22;
    prometheus = {
      enable = true;
      port = 2112;
    };
  };

  networking.nameservers = [
    "2606:4700:4700::1111"
    "1.1.1.1"
  ];
}
