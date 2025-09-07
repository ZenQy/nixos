{ ... }:

{
  imports = [
    ./hardware.nix
  ];
  nix.settings.substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
  ];

  # 启用/停用WIFI
  # networking.wireless = with builtins; {
  #   enable = true;
  #   networks =
  #     let
  #       s = secrets.wireless.password;
  #       list = map (x: {
  #         name = x;
  #         value = {
  #           psk = s."${x}";
  #         };
  #       }) (attrNames s);
  #     in
  #     listToAttrs list;
  # };

  systemd.network.networks =
    let
      nc = {
        DHCP = "ipv6";
        # IPv6AcceptRA = false;
        # LinkLocalAddressing = false;
      };
    in
    {
      enp3s0 = {
        name = "enp3s0";
        networkConfig = {
          Address = "10.0.0.33/24";
          Gateway = "10.0.0.1";
        }
        // nc;
      };
      # enp4s0 = {
      #   name = "enp4s0";
      #   networkConfig = {
      #     Address = "10.0.0.44/24";
      #   }
      #   // nc;
      # };
      # wlp5s0 = {
      #   name = "wlp5s0";
      #   networkConfig = {
      #     Address = "10.0.0.55/24";
      #   }
      #   // nc;
      # };
    };

}
