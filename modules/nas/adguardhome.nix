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
        bind_hosts = [ "127.0.0.1" ];
        port = 53;
        upstream_dns = [
          "114.114.114.114"
          "119.29.29.29"
          "223.5.5.5"
        ];
        bootstrap_dns = [
          "149.112.112.10"
          "9.9.9.10"
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
