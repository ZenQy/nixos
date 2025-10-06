{ ... }:

{
  services.adguardhome = {
    enable = true;
    settings = {
      users = [
        {
          name = "root";
          password = "$2a$10$TeNbO10.lFaY6V/GPda9GejiBw5A98.f8JWwgndncmPa7i/CMEVNW";
        }
      ];
      theme = "auto";
      language = "zh-cn";
      dns = {
        bind_hosts = [ "0.0.0.0" ];
        port = 53;
        upstream_mode = "load_balance";
        upstream_dns = [
          "https://dns.alidns.com/dns-query"
          "https://dns.pub/dns-query"
        ];
        bootstrap_dns = [ "223.5.5.5" ];
      };
    };
  };
}
