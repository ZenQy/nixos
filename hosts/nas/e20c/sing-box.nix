{
  secrets,
  pkgs,
  ...
}:

let
  log = {
    level = "info";
    timestamp = false;
  };
  dns = {
    servers = [
      {
        tag = "dns_proxy";
        type = "https";
        server = "1.1.1.1";
        detour = "proxy";
      }
      {
        tag = "dns_direct";
        type = "udp";
        server = "223.5.5.5";
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
        clash_mode = "direct";
        server = "dns_direct";
      }
      {
        rule_set = "custom_direct";
        server = "dns_direct";
      }
      {
        rule_set = "custom_proxy";
        server = "dns_fakeip";
      }
      {
        rule_set = "geosite-category-ads-all";
        action = "predefined";
        rcode = "REFUSED";
      }
      {
        rule_set = "geosite-cn";
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
        tag = "custom_direct";
        type = "inline";
        rules = [
          {
            ip_cidr = secrets.nezha-agent.server;
            port = secrets.nezha.listenport;
          }
          {
            domain_suffix = [
              ".cn"
              "10155.com"
              "allawnfs.com"
              "binmt.cc"
              "blizzard.com"
              "epicgames.com"
              "msftconnecttest.com"
              "nezha.${secrets.domain}"
              "oracle.com"
              "test-ipv6.com"
            ];
          }
        ];
      }
      {
        tag = "custom_proxy";
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
        protocol = "dns";
        action = "hijack-dns";
      }
      {
        ip_is_private = true;
        outbound = "direct";
      }
      {
        clash_mode = "global";
        outbound = "proxy";
      }
      {
        clash_mode = "direct";
        outbound = "direct";
      }
      {
        rule_set = "custom_direct";
        outbound = "direct";
      }
      {
        rule_set = "custom_proxy";
        outbound = "proxy";
      }
      {
        rule_set = "geosite-category-ads-all";
        action = "reject";
      }
      {
        rule_set = "geosite-cn";
        outbound = "direct";
      }
      {
        rule_set = "geoip-cn";
        outbound = "direct";
      }
    ];
    final = "proxy";
    auto_detect_interface = true;
    default_domain_resolver = "dns_direct";
  };
  inbounds = [
    # {
    #   tag = "tun-in";
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
      tag = "tproxy-in";
      type = "tproxy";
      listen = "::";
      listen_port = 12345;
      tcp_fast_open = true;
    }
  ];
  outbounds =
    let
      sb = secrets.sing-box;
      tuicList = [
        "osaka-1"
        "osaka-2"
        "sailor"
        "natvps"
        "alice"
      ];
      anytlsList = [
        "lxc-us-18"
      ];
      vlessList = [
        "bwh"
      ];
    in

    map (tag: {
      inherit tag;
      type = "vless";
      server = "${tag}.${secrets.domain}";
      server_port = 43388;
      inherit (sb.vless) uuid;
      flow = "xtls-rprx-vision";
      tls = {
        enabled = true;
        utls.enabled = true;
        # alpn = "h2";
        inherit (sb.vless.reality) server_name;
        reality = {
          enabled = true;
          inherit (sb.vless.reality) public_key short_id;
        };
      };
    }) vlessList
    ++ map (tag: {
      inherit tag;
      type = "anytls";
      server = "${tag}.${secrets.domain}";
      server_port = 34443;
      inherit (sb.anytls) password;
      tls = {
        enabled = true;
        utls.enabled = true;
        alpn = "h2";
        inherit (sb.anytls.reality) server_name;
        reality = {
          enabled = true;
          inherit (sb.anytls.reality) public_key short_id;
        };
      };
    }) anytlsList
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
    ++ [
      {
        tag = "proxy";
        type = "selector";
        outbounds = [
          "auto"
          "direct"
        ]
        ++ vlessList
        ++ anytlsList
        ++ tuicList;
      }
      {
        tag = "auto";
        type = "urltest";
        outbounds = vlessList ++ anytlsList ++ tuicList;
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
