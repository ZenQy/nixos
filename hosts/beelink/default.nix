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
    networks = {
      "Redmi_5G_4504".psk = secrets.wireless."Redmi_5G_4504".password;
      "160244823-5G".psk = secrets.wireless."160244823-5G".password;
      "iQOO_Neo5".psk = secrets.wireless."iQOO_Neo5".password;
    };
  };
  systemd.network.networks =
    let
      n = {
        gateway = [ "10.0.0.11" ];
        dns = [
          # "119.29.29.29"
          # "223.5.5.5"
          "114.114.114.114"
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
        address = [ "10.0.0.40/24" ];
      } // n;
      wlp5s0 = {
        name = "wlp5s0";
        address = [ "10.0.0.50/24" ];
      } // n;
    };

}
