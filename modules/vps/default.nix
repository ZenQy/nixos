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
    "net.core.default_qdisc" = "fq";
    "net.core.rmem_default" = 1048576;
    "net.core.rmem_max" = 2621440;
    "net.core.wmem_default" = 1048576;
    "net.core.wmem_max" = 2621440;
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.ipv4.tcp_mem" = "32768  196608  262144";
    "net.ipv4.tcp_rmem" = "524288  1048576  2621440";
    "net.ipv4.tcp_wmem" = "524288  1048576  2621440";
  };
  documentation.nixos.enable = false;
}
