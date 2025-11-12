{
  config,
  lib,
  secrets,
  ...
}:

let
  host = config.networking.hostName;
  isAlice = host == "alice";
  isDmit = host == "dmit";
  sb = secrets.sing-box;

  log = {
    disabled = false;
    level = "info";
    timestamp = true;
  };
  inbounds =
    if isDmit then
      [
        {
          tag = "vless";
          type = "vless";
          listen = "::";
          listen_port = 443;
          users = [
            {
              inherit (sb.vless) uuid;
              flow = "xtls-rprx-vision";
            }
          ];
          tls = {
            enabled = true;
            alpn = "h2";
            inherit (sb.vless.reality) server_name;
            reality = {
              enabled = true;
              handshake = {
                server = sb.vless.reality.server_name;
                server_port = 443;
              };
              inherit (sb.vless.reality) private_key short_id;
              max_time_difference = "1m0s";
            };
          };
        }
      ]
    else
      [
        {
          tag = "tuic";
          type = "tuic";
          listen = "::";
          listen_port = 443;
          users = [
            {
              inherit (sb.tuic) uuid;
            }
          ];
          congestion_control = "bbr";
          zero_rtt_handshake = false;
          tls = {
            enabled = true;
            alpn = "h3";
            acme = {
              domain = "${host}.${secrets.domain}";
              inherit (sb) email;
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
  outbounds = [
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
          outbounds = map (p: toString p) sb.socks5.server_port;
        }
      ]
      ++ map (p: {
        tag = toString p;
        type = "socks";
        version = "5";
        server_port = p;
        inherit (sb.socks5)
          server
          username
          password
          ;
      }) sb.socks5.server_port
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
