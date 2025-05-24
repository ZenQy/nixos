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
      nc = {
        Gateway = [
          "10.0.0.11"
          secrets.hosts.beelink.ipv6.gateway
        ];
        DHCP = false;
        IPv6AcceptRA = false;
        LinkLocalAddressing = false;
      };
    in
    {
      enp3s0 = {
        name = "enp3s0";
        networkConfig = {
          DHCP = "yes";
        };
      };
      enp4s0 = {
        name = "enp4s0";
        networkConfig = {
          Address = "10.0.0.24/24";
        } // nc;
      };
      wlp5s0 = {
        name = "wlp5s0";
        networkConfig = {
          Address = [
            "10.0.0.25/24"
            secrets.hosts.beelink.ipv6.ip
          ];
        } // nc;
      };
    };
}
