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
    #     alpn = "h2";
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
          tag = "socks";
          type = "socks";
          version = "5";
          inherit (secrets.sing-box.socks5)
            server
            server_port
            username
            password
            ;
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
