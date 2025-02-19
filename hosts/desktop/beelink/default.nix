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
        gateway = [
          "10.0.0.11"
          secrets.beelink.ipv6.gateway
        ];
        DHCP = "no";
        networkConfig = {
          IPv6AcceptRA = "no";
          LinkLocalAddressing = "no";
        };
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
          "10.0.0.24/24"
        ];
      } // n;
      wlp5s0 = {
        name = "wlp5s0";
        address = [
          "10.0.0.25/24"
          secrets.beelink.ipv6.ip
        ];
      } // n;
    };

}
