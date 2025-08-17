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
        server = "114.114.114.114";
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
        server = "dns_proxy";
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
    ];
    final = "dns_proxy";
    strategy = "prefer_ipv4";
  };
  route = {
    rule_set = [
      {
        tag = "custom_direct";
        type = "inline";
        rules = [
          {
            process_name = [
              "nezha-agent"
              "transmission-daemon"
            ];
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
  };
  inbounds = [
    {
      type = "tun";
      tag = "tun-in";
      address = [
        "172.18.0.1/24"
        "fdfe:dcba:9876::1/64"
      ];
      mtu = 1500;
      auto_route = true;
      strict_route = false;
      stack = "gvisor";
      include_package = [
        "InfinityLoop1309.NewPipeEnhanced"
        "app.aiaw"
        "cn.jimex.dict"
        "com.aistra.hail"
        "com.aurora.store"
        "com.deskangel.daremote"
        "com.google.android.gms"
        "com.ichi2.anki"
        "com.x8bit.bitwarden"
        "com.xbrowser.play"
        "io.legado.app.release"
        "mark.via"
        "mark.via.gp"
        "me.bmax.apatch"
        "org.telegram.messenger"
        "pro.cubox.androidapp"
        "top.achatbot.aichat"
        "xyz.chatboxapp.chatbox"
      ];
    }
  ];
  outbounds =
    let
      tuicList = [
        "osaka-1"
        "osaka-2"
        "sailor"
        "natvps"
        "alice"
      ];
      anytlsList = [
        "lxc-us-18"
        "lxc-jp-1"
      ];
    in
    map (tag: {
      inherit tag;
      type = "anytls";
      server = "${tag}.${secrets.domain}";
      server_port = if tag == "lxc-us-18" || tag == "lxc-jp-1" then 44443 else 443;
      inherit (secrets.sing-box.anytls) password;
      tls = {
        enabled = true;
        utls.enabled = true;
        alpn = "h2";
        inherit (secrets.sing-box.reality) server_name;
        reality = {
          enabled = true;
          inherit (secrets.sing-box.reality) public_key short_id;
        };
      };
    }) anytlsList
    ++ map (tag: {
      inherit tag;
      type = "tuic";
      server = "${tag}.${secrets.domain}";
      server_port = 443;
      inherit (secrets.sing-box.tuic) uuid;
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
        ]
        ++ anytlsList
        ++ tuicList;
      }
      {
        tag = "auto";
        type = "urltest";
        outbounds = anytlsList ++ tuicList;
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

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };
}
