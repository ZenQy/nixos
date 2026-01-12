{
  config,
  lib,
  secrets,
  ...
}:

let
  host = config.networking.hostName;
  isIPv6Only = host == "alice" || host == "icmp9";
  isOptimized = host == "dmit" || host == "bwh";
  sb = secrets.sing-box;

  log = {
    disabled = false;
    level = "info";
    timestamp = true;
  };
  inbounds =
    if isOptimized then
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
  endpoints = [
    {
      type = "wireguard";
      tag = "wireguard";
      mtu = 1280;
      inherit (sb.wireguard) address private_key;
      peers = [
        {
          address = "engage.cloudflareclient.com";
          port = 2408;
          allowed_ips = "0.0.0.0/0";
          inherit (sb.wireguard) public_key;
        }
      ];
    }
  ];
  outbounds = [
    {
      tag = "direct";
      type = "direct";
    }
  ];
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
    final = "wireguard";
  };

in
{
  services.sing-box = {
    enable = lib.mkDefault true;
    settings = {
      inherit log inbounds outbounds;
    }
    // (if isIPv6Only then { inherit dns route endpoints; } else { });
  };
}
