{
  config,
  lib,
  secrets,
  ...
}:

let
  host = config.networking.hostName;
  isAlice = host == "alice";
  log = {
    disabled = false;
    level = "info";
    timestamp = true;
  };
  inbounds = [
    # {
    #   type = "anytls";
    #   listen = "::";
    #   listen_port = 443;
    #   users = [
    #     {
    #       inherit (secrets.sing-box.anytls) password;
    #     }
    #   ];
    #   tls = {
    #     enabled = true;
    #     inherit (secrets.sing-box.anytls.reality) server_name;
    #     reality = {
    #       enabled = true;
    #       handshake = {
    #         server = secrets.sing-box.anytls.reality.server_name;
    #         server_port = 443;
    #       };
    #       inherit (secrets.sing-box.anytls.reality) private_key short_id;
    #       max_time_difference = "1m0s";
    #     };
    #   };
    # }
    {
      type = "tuic";
      listen = "::";
      listen_port = 443;
      users = [
        {
          inherit (secrets.sing-box.tuic) uuid;
        }
      ];
      congestion_control = "bbr";
      zero_rtt_handshake = false;
      tls = {
        enabled = true;
        alpn = "h3";
        acme = {
          domain = "${host}.940940.xyz";
          inherit (secrets.sing-box) email;
        };
      };
    }
  ];
  outbounds = [
    {
      type = "direct";
    }
  ]
  ++ (
    if isAlice then
      [
        {
          type = "socks";
          tag = "socks";
          server = "2a14:67c0:116::1";
          server_port = 20000;
          version = "5";
          username = "alice";
          password = "alicefofo123..OVO";
        }
      ]
    else
      [ ]
  );
  route.rules = [
    {
      ip_version = 4;
      outbound = "socks";
    }
  ];

in
{
  services.sing-box = {
    enable = lib.mkDefault true;
    settings = {
      inherit log inbounds outbounds;
    }
    // (if isAlice then { inherit route; } else { });
  };
}
