{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];
  nix.settings.substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
  ];
  networking.wireless = with builtins; {
    enable = true;
    networks =
      let
        s = secrets.wireless.password;
        list = map (x: {
          name = x;
          value = {
            psk = s."${x}";
          };
        }) (attrNames s);
      in
      listToAttrs list;
  };
  systemd.network.networks =
    let
      n = {
        routes = [
          { Gateway = "10.0.0.11"; }
          {
            Gateway = secrets.beelink.ipv6.gateway;
            GatewayOnLink = true;
          }
        ];
        DHCP = "no";
      };
    in
    {
      enp3s0 = {
        name = "enp3s0";
        DHCP = "yes";
      };
      enp4s0 = {
        name = "enp4s0";
        address = [
          "10.0.0.40/24"
          secrets.beelink.ipv6.ip
        ];
      } // n;
      wlp5s0 = {
        name = "wlp5s0";
        address = [
          "10.0.0.50/24"
          secrets.beelink.ipv6.ip
        ];
      } // n;
    };

}
