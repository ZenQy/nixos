{ ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    address = [
      "192.168.202.27/24"
      "2607:5300:60:2288:1c::a/80"
    ];
    routes = [
      { Gateway = "192.168.202.1"; }
      {
        Gateway = "2607:5300:60:2288:2::2";
        GatewayOnLink = true;
      }
    ];
  };

  services.openssh.ports = [ 22 ];
}
