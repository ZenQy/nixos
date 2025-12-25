{
  secrets,
  pkgs,
  ...
}:

let
  sb = secrets.sing-box;
  log = {
    level = "info";
    timestamp = false;
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
        inet6_range = "fc00::/18";
      }
    ];
    rules = [
      {
        rule_set = "geosite-category-ads-all";
        action = "reject";
      }
      {
        rule_set = "inline_proxy";
        server = "dns_fakeip";
      }
      {
        protocol = "bittorrent";
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
              ".ip.zstaticcdn.com"
              "10155.com"
              "ahrefs.com"
              "allawnfs.com"
              "binmt.cc"
              "blizzard.com"
              "blog.cloudflare.com"
              "developers.cloudflare.com"
              "epicgames.com"
              "hostinger.com"
              "msftconnecttest.com"
              "natchecker.com"
              "oracle.com"
              "test-ipv6.com"
              "wmviv.com"
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
            ];
          }
        ];
      }
      {
        tag = "geosite-cn";
        type = "remote";
        format = "binary";
        url = "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-cn.srs";
        download_detour = "proxy";
      }
      {
        tag = "geoip-cn";
        type = "remote";
        format = "binary";
        url = "https://raw.githubusercontent.com/SagerNet/sing-geoip/rule-set/geoip-cn.srs";
        download_detour = "proxy";
      }
      {
        tag = "geosite-category-ads-all";
        type = "remote";
        format = "binary";
        url = "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-category-ads-all.srs";
        download_detour = "proxy";
      }
    ];
    rules = [
      {
        action = "sniff";
      }
      {
        process_name = "AdGuardHome";
        outbound = "direct";
      }
      {
        protocol = "dns";
        action = "hijack-dns";
      }
      {
        rule_set = "inline_proxy";
        outbound = "proxy";
      }
      {
        protocol = "bittorrent";
        outbound = "direct";
      }
      {
        ip_is_private = true;
        rule_set = [
          "inline_direct"
          "geosite-cn"
          "geoip-cn"
        ];
        outbound = "direct";
      }
    ];
    final = "proxy";
    auto_detect_interface = true;
    default_domain_resolver = "dns_direct";
  };
  inbounds = [
    # {
    #   tag = "tun";
    #   type = "tun";
    #   address = [
    #     "172.18.0.1/24"
    #     "fdfe:dcba:9876::1/64"
    #   ];
    #   mtu = 1500;
    #   auto_route = true;
    #   strict_route = false;
    #   stack = "gvisor";
    #   include_package = [
    #     "InfinityLoop1309.NewPipeEnhanced"
    #     "app.aiaw"
    #     "cn.jimex.dict"
    #     "com.aistra.hail"
    #     "com.aurora.store"
    #     "com.deskangel.daremote"
    #     "com.google.android.gms"
    #     "com.ichi2.anki"
    #     "com.x8bit.bitwarden"
    #     "com.xbrowser.play"
    #     "io.legado.app.release"
    #     "mark.via"
    #     "mark.via.gp"
    #     "me.bmax.apatch"
    #     "org.telegram.messenger"
    #     "pro.cubox.androidapp"
    #     "top.achatbot.aichat"
    #     "xyz.chatboxapp.chatbox"
    #   ];
    # }
    {
      tag = "tproxy";
      type = "tproxy";
      listen = "::";
      listen_port = 12345;
      tcp_fast_open = true;
    }
    {
      type = "mixed";
      listen = "0.0.0.0";
      listen_port = 1080;
      set_system_proxy = false;
    }
  ];
  outbounds =
    let
      utls = {
        enabled = true;
        fingerprint = "safari";
      };
      tuicList = [
        "osaka-1"
        "osaka-2"
        "sailor"
        "alice"
      ];
      vlessList = [
        "dmit-4"
        "dmit-6"
      ];
      trojanList = [
        sb.trojan.host
        "bestcf.top"
        "cdn.2020111.xyz"
        "cdn.tzpro.xyz"
        "cf.0sm.com"
        "cf.877771.xyz"
        "cfip.1323123.xyz"
        "cloudflare-ip.mofashi.ltd"
        "cloudflare.182682.xyz"
        "cnamefuckxxs.yuchen.icu"
        "freeyx.cloudflare88.eu.org"
      ];
    in
    sb.node
    ++ map (tag: {
      inherit tag;
      type = "vless";
      server = "${tag}.${secrets.domain}";
      server_port = 443;
      inherit (sb.vless) uuid;
      flow = "xtls-rprx-vision";
      tls = {
        enabled = true;
        alpn = "h2";
        inherit utls;
        inherit (sb.vless.reality) server_name;
        reality = {
          enabled = true;
          inherit (sb.vless.reality) public_key short_id;
        };
      };
    }) vlessList
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
    }) tuicList
    ++ map (tag: {
      inherit tag;
      type = "trojan";
      server = tag;
      server_port = 443;
      inherit (sb.trojan) password;
      transport = {
        type = "ws";
        path = "/";
        headers.Host = sb.trojan.host;
      };
      tls = {
        enabled = true;
        server_name = sb.trojan.host;
        alpn = "h3";
        inherit utls;
      };
    }) trojanList
    ++ [
      {
        tag = "proxy";
        type = "selector";
        outbounds = map (s: s.tag) sb.node ++ vlessList ++ tuicList ++ trojanList ++ [ "direct" ];
      }
      {
        tag = "direct";
        type = "direct";
      }
    ];
  experimental = {
    cache_file = {
      enabled = true;
      path = "cache.db";
    };
    clash_api = {
      external_controller = "0.0.0.0:9090";
      external_ui = "${pkgs.metacubexd}";
    };
  };

in
{
  services.sing-box = {
    enable = true;
    settings = {
      inherit
        log
        dns
        route
        inbounds
        outbounds
        experimental
        ;
    };
  };
}
