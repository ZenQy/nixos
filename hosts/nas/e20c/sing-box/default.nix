{
  secrets,
  pkgs,
  ...
}:

let
  sb = secrets.sing-box;
  tproxy_port = 12345;
  fake_ipv6 = "fc00::/18";
  log = {
    level = "info";
    timestamp = true;
  };
  dns = {
    servers = [
      {
        tag = "dns_direct";
        type = "udp";
        server = "127.0.0.53";
      }
      {
        tag = "dns_fakeip";
        type = "fakeip";
        inet4_range = "198.18.0.0/15";
        inet6_range = fake_ipv6;
      }
    ];
    rules = [
      {
        clash_mode = "direct";
        server = "dns_direct";
      }
      {
        clash_mode = "global";
        server = "dns_fakeip";
      }
      {
        rule_set = "geosite-category-ads-all";
        action = "reject";
      }
      {
        rule_set = "inline_proxy";
        server = "dns_fakeip";
      }
      {
        protocol = [
          "bittorrent"
          "ssh"
        ];
        server = "dns_direct";
      }
      {
        rule_set = [
          "inline_direct"
          "geosite-cn"
        ];
        server = "dns_direct";
      }
      {
        query_type = [
          "A"
          "AAAA"
        ];
        server = "dns_fakeip";
      }
    ];
    final = "dns_direct";
    strategy = "prefer_ipv6";
  };
  route = {
    rule_set = [
      {
        tag = "inline_direct";
        type = "inline";
        rules = [
          {
            domain_suffix = [
              ".cn"
              "10155.com"
              "940940.xyz"
              "ahrefs.com"
              "allawnfs.com"
              "binmt.cc"
              "blizzard.com"
              "blog.cloudflare.com"
              "developers.cloudflare.com"
              # "epicgames.com"
              "geevisit.com" # 解决跨域
              "hostinger.com"
              "icanhazip.com"
              "ip.sb"
              "ip.zstaticcdn.com"
              "ipify.org"
              "msftconnecttest.com"
              "natchecker.com"
              "oracle.com"
              "oraclecloud.com"
              "oracleinfinity.io"
              "test-ipv6.com"
              "wmviv.com"
              "zxinc.org"
            ];
          }
        ];
      }
      {
        tag = "inline_proxy";
        type = "inline";
        rules = [
          {
            domain_suffix = [
              "googleapis.cn"
              "gstatic.com"
            ];
          }
        ];
      }
      {
        tag = "geosite-cn";
        type = "remote";
        format = "binary";
        url = "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-cn.srs";
        update_interval = "10d";
      }
      {
        tag = "geoip-cn";
        type = "remote";
        format = "binary";
        url = "https://raw.githubusercontent.com/SagerNet/sing-geoip/rule-set/geoip-cn.srs";
        update_interval = "10d";
      }
      {
        tag = "geosite-category-ads-all";
        type = "remote";
        format = "binary";
        url = "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-category-ads-all.srs";
        update_interval = "10d";
      }
      {
        tag = "geosite-openai";
        type = "remote";
        format = "binary";
        url = "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-openai.srs";
        update_interval = "10d";
      }
      {
        tag = "geosite-google-gemini";
        type = "remote";
        format = "binary";
        url = "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-google-gemini.srs";
        update_interval = "10d";
      }
    ];
    rules = [
      {
        action = "sniff";
      }
      {
        process_name = [
          "AdGuardHome"
          "yx"
        ];
        outbound = "direct";
      }
      {
        protocol = "dns";
        action = "hijack-dns";
      }
      {
        ip_is_private = true;
        outbound = "direct";
      }
      {
        clash_mode = "direct";
        outbound = "direct";
      }
      {
        clash_mode = "global";
        outbound = "proxy";
      }
      {
        rule_set = "inline_proxy";
        outbound = "proxy";
      }
      {
        protocol = [
          "bittorrent"
          "ssh"
        ];
        outbound = "direct";
      }
      {
        rule_set = [
          "inline_direct"
          "geosite-cn"
          "geoip-cn"
        ];
        outbound = "direct";
      }
      {
        rule_set = "geosite-openai";
        outbound = "openai";
      }
      {
        rule_set = "geosite-google-gemini";
        outbound = "gemini";
      }
    ];
    final = "proxy";
    auto_detect_interface = true;
    default_domain_resolver = "dns_direct";
    default_http_client = "default_http_client";
  };
  inbounds = [
    {
      tag = "tproxy";
      type = "tproxy";
      listen = "::";
      listen_port = tproxy_port;
      tcp_fast_open = true;
    }
  ];
  outbounds =
    let
      nodes = import ./nodes.nix;
      openai-nodes = nodes.openai;
      gemini-nodes = nodes.gemini;
      tuic-nodes = nodes.tuic;
      anytls-nodes = nodes.anytls;
      cloudflare-nodes = import ./cloudflare.nix;
    in
    sb.nodes
    ++ map (tag: {
      inherit tag;
      type = "anytls";
      server = "${tag}.${secrets.domain}";
      server_port = 443;
      inherit (sb.anytls) password;
      tls = {
        enabled = true;
        alpn = "h2";
      };
    }) anytls-nodes
    ++ map (tag: {
      inherit tag;
      type = "tuic";
      server = "${tag}.${secrets.domain}";
      server_port = 443;
      inherit (sb.tuic) uuid;
      congestion_control = "bbr";
      udp_relay_mode = "native";
      udp_over_stream = false;
      zero_rtt_handshake = false;
      tls = {
        enabled = true;
        alpn = "h3";
      };
    }) tuic-nodes
    ++ map (tag: {
      inherit tag;
      type = "trojan";
      server = tag;
      server_port = 443;
      inherit (sb.cloudflare) password;
      transport = {
        type = "ws";
        path = "/";
        headers.Host = sb.cloudflare.host;
      };
      tls = {
        enabled = true;
        server_name = sb.cloudflare.host;
        alpn = "h3";
      };
    }) cloudflare-nodes
    ++ [
      {
        tag = "proxy";
        type = "selector";
        outbounds =
          map (s: s.tag) sb.nodes
          ++ anytls-nodes
          ++ tuic-nodes
          ++ [
            "cloudflare"
          ];
      }
      {
        tag = "cloudflare";
        type = "urltest";
        outbounds = cloudflare-nodes;
      }
      {
        tag = "openai";
        type = "selector";
        outbounds = openai-nodes;
      }
      {
        tag = "gemini";
        type = "selector";
        outbounds = gemini-nodes;
      }
      {
        tag = "direct";
        type = "direct";
      }
    ];
  endpoints = [
    {
      type = "tailscale";
      tag = "tailscale";
      auth_key = sb.tailscale;
      ephemeral = false;
      accept_routes = false; # 手机端设置为true,可访问家庭内网
      advertise_routes = [ "10.0.0.0/24" ]; # 手机端可删除
      advertise_exit_node = false;
      udp_timeout = "5m";
    }
  ];
  experimental = {
    cache_file = {
      enabled = true;
      path = "cache.db";
      store_fakeip = true;
      store_dns = true;
    };
  };
  services = [
    {
      tag = "api";
      type = "api";
      listen = "::";
      listen_port = 9090;
      secret = secrets.user.password.zenith;
      access_control_allow_private_network = true;
      dashboard = {
        enabled = true;
        path = "${pkgs.sing-box-dashboard}";
        update_interval = "0";
      };
    }
  ];
  http_clients = [
    {
      tag = "default_http_client";
      version = 2;
      disable_version_fallback = true;
      tls = {
        enabled = true;
        alpn = "h2";
      };
    }
  ];
in
{

  services.sing-box = {
    enable = true;
    settings = {
      inherit
        dns
        log
        route
        inbounds
        services
        endpoints
        outbounds
        experimental
        http_clients
        ;
    };
  };

  systemd.services.sing-box.serviceConfig = import ./service.nix {
    inherit pkgs fake_ipv6;
    tproxy_port = toString tproxy_port;
  };

}
