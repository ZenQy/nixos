{
  pkgs,
  secrets,
  ...
}:

let
  inherit (builtins)
    concatLists
    genList
    length
    elemAt
    ;
  sb = secrets.sing-box;
  tproxy_port = 12345;
  log = {
    level = "info";
    timestamp = true;
  };
  dns = {
    servers = [
      {
        tag = "dns_direct";
        type = "udp";
        server = "127.0.0.1";
      }
      {
        tag = "dns_proxy";
        type = "https";
        server = "8.8.8.8";
        detour = "proxy";
      }
      {
        tag = "dns_fakeip";
        type = "fakeip";
        inet4_range = "198.18.0.0/15";
        inet6_range = "fc00::/18";
      }
    ];
    rules = [
      {
        rule_set = "geosite-category-ads-all";
        action = "reject";
      }
      {
        protocol = [
          "bittorrent"
          "ssh"
        ];
        server = "dns_direct";
      }
      {
        clash_mode = "direct";
        server = "dns_direct";
      }
      {
        clash_mode = "global";
        server = "dns_proxy";
      }
      {
        rule_set = [
          "inline_proxy"
          "geosite-category-ai-!cn.srs"
        ];
        server = "dns_fakeip";
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
    final = "dns_proxy";
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
              "xf-yun.com"
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
        tag = "geosite-category-ai-!cn.srs";
        type = "remote";
        format = "binary";
        url = "https://raw.githubusercontent.com/SagerNet/sing-geosite/refs/heads/rule-set/geosite-category-ai-!cn.srs";
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
          "smartdns"
          "dnsmasq"
          "mcis"
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
        rule_set = "geosite-category-ads-all";
        action = "reject";
      }
      {
        protocol = [
          "bittorrent"
          "ssh"
        ];
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
        rule_set = "inline_direct";
        outbound = "direct";
      }
      {
        rule_set = "inline_proxy";
        outbound = "proxy";
      }
      {
        rule_set = "geosite-category-ai-!cn.srs";
        outbound = "ai";
      }
      {
        rule_set = [
          "geosite-cn"
          "geoip-cn"
        ];
        outbound = "direct";
      }
    ];
    final = "proxy";
    auto_detect_interface = true;
    default_domain_resolver = "dns_direct";
    default_http_client = "default_http_client";
  };
  inbounds = [
    {
      tag = "tun";
      type = "tun";
      address = [
        "172.18.0.1/24"
        "fdfe:dcba:9876::1/64"
      ];
      auto_redirect = true;
      auto_route = true;
      dns_mode = "disabled";
      include_mac_address = [
        "70:70:fc:03:2c:08" # BeeLink
        "70:70:fc:03:2c:09" # BeeLink
        "0c:91:92:f2:d2:e9" # BeeLink
        "12:a9:f6:67:39:e9" # E20C
        "00:e0:4c:0d:1b:36" # E20C
        "00:e0:4c:68:00:7a" # Rock-5B
        "d6:51:eb:55:bd:27" # OECT
        "30:5a:3a:7b:fd:e4" # ASUS
        "34:2d:a3:ca:bb:84" # FiberHome
      ];
      include_package = [
        "InfinityLoop1309.NewPipeEnhanced"
        "app.aiaw"
        "cn.jimex.dict"
        "com.aistra.hail"
        "com.aurora.store"
        "com.deskangel.daremote"
        "com.google.android.gms"
        "com.ichi2.anki"
        "com.mmbox.xbrowser.pro"
        "com.mmbox.xbrowser"
        "com.x8bit.bitwarden"
        "com.xbrowser.play"
        "io.legado.app.release"
        "io.legato.kazusa"
        "mark.via"
        "mark.via.gp"
        "me.bmax.apatch"
        "org.telegram.messenger"
        "org.telegram.messenges"
        "pro.cubox.androidapp"
        "top.achatbot.aichat"
        "xyz.chatboxapp.chatbox"
      ];
      mtu = 1500;
      strict_route = false;
    }
    # 当前用于为openwrt/手机生成配置，E20C实际使用tproxy
    # {
    #   tag = "tproxy";
    #   type = "tproxy";
    #   listen = "::";
    #   listen_port = tproxy_port;
    #   tcp_fast_open = true;
    # }
  ];
  outbounds =
    let
      nodes = import ./nodes.nix;
      tuic-nodes = nodes.tuic;
      cloudflare-nodes = import ./cloudflare.nix;
    in
    sb.nodes
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
    ++ concatLists (
      genList (
        i:
        let
          server = elemAt cloudflare-nodes i;
          tag = toString (i + 1);
        in
        [
          {
            tag = "CDN-${tag}";
            type = "vless";
            inherit server;
            server_port = 443;
            inherit (sb.cloudflare) uuid;
            multiplex.enabled = true;
            transport = {
              type = "ws";
              path = "/";
              headers.Host = sb.cloudflare.host;
            };
            tls = {
              enabled = true;
              server_name = sb.cloudflare.host;
            };
          }
          {
            tag = "CF-${tag}";
            type = "vless";
            inherit server;
            server_port = 443;
            inherit (sb.cloudflare) uuid;
            transport = {
              type = "ws";
              path = "/";
              headers.Host = "cf.${secrets.domain}";
              max_early_data = 2048;
              early_data_header_name = "Sec-WebSocket-Protocol";
            };
            tls = {
              enabled = true;
              server_name = "cf.${secrets.domain}";
            };
          }
        ]
      ) (length cloudflare-nodes)
    )
    ++ [
      {
        tag = "proxy";
        type = "selector";
        outbounds =
          map (s: s.tag) sb.nodes
          ++ tuic-nodes
          ++ [
            "cloudflare"
          ];
      }
      {
        tag = "cloudflare";
        type = "selector";
        outbounds = concatLists (
          genList (
            i:
            let
              tag = toString (i + 1);
            in
            [
              "CDN-${tag}"
              "CF-${tag}"
            ]
          ) (length cloudflare-nodes)
        );
      }
      {
        tag = "ai";
        type = "urltest";
        outbounds =
          concatLists (
            genList (
              i:
              let
                tag = toString (i + 1);
              in
              [
                "CDN-${tag}"
              ]
            ) (length cloudflare-nodes)
          )
          ++ [ "osaka-1" ];
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
  experimental.cache_file = {
    enabled = true;
    path = "cache.db";
    store_fakeip = true;
    store_dns = true;
  };
  services = [
    {
      tag = "api";
      type = "api";
      listen = "::";
      listen_port = 9090;
      secret = sb.secret;
      access_control_allow_private_network = true;
      dashboard = {
        enabled = true;
        # path = "${pkgs.sing-box-dashboard}";
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
      detour = "proxy";
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
    inherit pkgs;
    tproxy_port = toString tproxy_port;
  };

}
