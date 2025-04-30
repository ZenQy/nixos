{ secrets, ... }:

{
  services.adguardhome = {
    enable = true;
    settings = {
      users = [
        secrets.adguardhome
      ];
      language = "zh-cn";
      theme = "auto";
      dns = {
        bind_hosts = [ "0.0.0.0" ];
        port = 53;
        upstream_dns = [
          "119.29.29.29"
          "223.5.5.5"
          "114.114.114.114"
        ];
        bootstrap_dns = [
          "9.9.9.10"
          "149.112.112.10"
        ];
        fallback_dns = [
          "1.1.1.1"
          "8.8.8.8"
        ];
        upstream_mode = "load_balance";
      };
    };
  };
}
