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
          "240e:361:8a53:fc00:3800:6bff:fe4f:4cf4"
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
          "240e:361:8a53:fc00:e91:92ff:fef2:d2e9/64"
        ];
      } // n;
      wlp5s0 = {
        name = "wlp5s0";
        address = [
          "10.0.0.50/24"
          "240e:361:8a53:fc00:e91:92ff:fef2:d2f9/64"
        ];
      } // n;
    };

}
