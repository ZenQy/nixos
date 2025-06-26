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
        address = "https://1.1.1.1/dns-query";
        detour = "proxy";
      }
      {
        tag = "dns_direct";
        address = "114.114.114.114";
        detour = "direct";
      }
      {
        tag = "dns_refused";
        address = "rcode://refused";
      }
      {
        tag = "dns_fakeip";
        address = "fakeip";
      }
    ];
    rules = [
      {
        outbound = "any";
        server = "dns_direct";
      }
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
        server = "dns_refused";
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
    fakeip = {
      enabled = true;
      inet4_range = "198.18.0.0/16";
      inet6_range = "fc00::/18";
    };
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
        "io.legado.app.release"
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
    map (tag: {
      inherit tag;
      type = "trojan";
      server = "${tag}.${secrets.domain}";
      server_port = if tag == "lxc-us" || tag == "lxc-hk" || tag == "hatch" then 11611 else 443;
      inherit (secrets.sing-box.trojan) password;
      transport = {
        type = "ws";
        inherit (secrets.sing-box.trojan) path;
      };
      tls = {
        enabled = true;
        utls.enabled = true;
      };
      multiplex.enabled = tag != "cf";
    }) secrets.sing-box.server
    ++ [
      {
        tag = "proxy";
        type = "selector";
        outbounds = secrets.sing-box.server;
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
