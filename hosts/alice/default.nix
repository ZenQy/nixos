{ ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    address = [
      "2a14:67c0:300::eb/128"
    ];
    routes = [
      {
        Gateway = "2a14:67c0:300::1";
        GatewayOnLink = true;
      }
    ];
  };

}
