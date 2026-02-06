{
  config,
  lib,
  secrets,
  ...
}:

let
  host = config.networking.hostName;
  isAlice = host == "alice";
  isIPv6Only = false;
  isOptimized = host == "dmit" || host == "bwh";
  sb = secrets.sing-box;
  # vlessNode = {
  #   tag = "vless";
  #   type = "vless";
  #   listen = "::";
  #   listen_port = 443;
  #   users = [
  #     {
  #       inherit (sb.vless) uuid;
  #       flow = "xtls-rprx-vision";
  #     }
  #   ];
  #   tls = {
  #     enabled = true;
  #     alpn = "h2";
  #     inherit (sb.vless.reality) server_name;
  #     reality = {
  #       enabled = true;
  #       handshake = {
  #         server = sb.vless.reality.server_name;
  #         server_port = 443;
  #       };
  #       inherit (sb.vless.reality) private_key short_id;
  #       max_time_difference = "1m0s";
  #     };
  #   };
  # };
  anytlsNode = {
    tag = "anytls";
    type = "anytls";
    listen = "::";
    listen_port = 443;
    users = [
      {
        inherit (sb.anytls) password;
      }
    ];
    tls = {
      enabled = true;
      alpn = "h2";
      acme = {
        domain = "${host}.${secrets.domain}";
        inherit (sb) dns01_challenge;
      };
    };
  };
  tuicNode = {
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
        inherit (sb) dns01_challenge;
      };
    };
  };
  wireguardNode = {
    tag = "wireguard";
    type = "wireguard";
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
  };
  socksNodes =
    let
      ports = sb.socks5.server_port;
    in
    [
      {
        tag = "socks";
        type = "urltest";
        outbounds = map (p: toString p) ports;
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
    }) ports;
  log = {
    disabled = false;
    level = "info";
    timestamp = true;
  };
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
  route.rules = [
    {
      action = "sniff";
    }
    {
      ip_version = 4;
      outbound = if isAlice then "socks" else "wireguard";
    }
  ];
  inbounds =
    if isOptimized then
      [
        # vlessNode
        anytlsNode
      ]
    else
      [ tuicNode ];
  outbounds = [ { type = "direct"; } ] ++ (if isAlice then socksNodes else [ ]);
  endpoints = if isIPv6Only then [ wireguardNode ] else [ ];
in
{
  services.sing-box = {
    enable = lib.mkDefault true;
    settings = {
      inherit log inbounds outbounds;
    }
    // (if isAlice || isIPv6Only then { inherit dns route endpoints; } else { });
  };
}
