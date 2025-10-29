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
    #   tag = "anytls";
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
      tag = "tuic";
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
          domain = "${host}.${secrets.domain}";
          inherit (secrets.sing-box) email;
        };
      };
    }
  ];
  dns = {
    servers = [
      {
        tag = "local";
        type = "local";
      }
    ];
    final = "local";
    strategy = "prefer_ipv6";
  };
  outbounds =
    let
      s = secrets.sing-box.socks5;
    in
    [
      {
        tag = "direct";
        type = "direct";
      }
    ]
    ++ (
      if isAlice then
        [
          {
            tag = "socks";
            type = "urltest";
            outbounds = map (p: toString p) s.server_port;
          }
        ]
        ++ map (p: {
          tag = toString p;
          type = "socks";
          version = "5";
          server_port = p;
          inherit (s)
            server
            username
            password
            ;
        }) s.server_port
      else
        [ ]
    );
  route = {
    rules = [
      {
        inbound = "tuic";
        action = "resolve";
        server = "local";
      }
      {
        ip_cidr = "::/0";
        outbound = "direct";
      }
    ];
    final = "socks";
  };

in
{
  services.sing-box = {
    enable = lib.mkDefault true;
    settings = {
      inherit log inbounds outbounds;
    }
    // (if isAlice then { inherit dns route; } else { });
  };
}
