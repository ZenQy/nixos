{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];
  nix.settings.substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
  ];
  networking.wireless = {
    enable = true;
    networks =
      let
        list = map (x: { name = x; value = { psk = secrets.wireless."${x}".password; }; })
          [ "Redmi_5G_4504" "160244823-5G" "iQOO_Neo5" "CMCC-ABA2" ];
      in
      builtins.listToAttrs list;
  };
  systemd.network.networks =
    let
      n =
        let ip = "10.0.0.11";
        in {
          gateway = [ ip ];
          dns = [ ip ];
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
        address = [ "10.0.0.40/24" ];
      } // n;
      wlp5s0 = {
        name = "wlp5s0";
        address = [ "10.0.0.50/24" ];
      } // n;
    };

}
