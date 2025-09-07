{ secrets, ... }:

{
  services.openssh = {
    enable = true;
    ports = [ secrets.openssh.port ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  users.users =
    let
      opensshKeys = {
        openssh.authorizedKeys.keys = [
          secrets.openssh.key
        ];
      };
    in
    {
      root = opensshKeys;
      nixos = opensshKeys;
    };

  boot.kernelParams = [
    "audit=0"
    "net.ifnames=0"
  ];
  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "cake";
    "net.core.rmem_default" = 262144;
    "net.core.rmem_max" = 208338944;
    "net.core.wmem_default" = 262144;
    "net.core.wmem_max" = 1561917063;
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.ipv4.tcp_rmem" = "32768 262144 208338944";
    "net.ipv4.tcp_wmem" = "32768 262144 1561917063";
  };

  documentation.nixos.enable = false;
}
