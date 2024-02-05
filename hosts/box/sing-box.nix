{ config, pkgs, lib, secrets, ... }:
let
  settings = {
    log = { level = "warn"; timestamp = false; };
    dns = {
      servers = [
        {
          tag = "dns_proxy";
          address = "https://1.1.1.1/dns-query";
          address_resolver = "dns_resolver";
          strategy = "ipv4_only";
          detour = "proxy";
        }
        {
          tag = "dns_direct";
          address = "https://dns.alidns.com/dns-query";
          address_resolver = "dns_resolver";
          strategy = "ipv4_only";
          detour = "direct";
        }
        {
          tag = "dns_resolver";
          address = "223.5.5.5";
          detour = "direct";
        }
        {
          tag = "dns_success";
          address = "rcode://success";
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
          server = "dns_resolver";
        }
        {
          rule_set = [
            "BlockHttpDNS"
            "geosite-category-ads-all"
          ];
          server = "dns_success";
          disable_cache = true;
        }
        {
          rule_set = "geosite-geolocation-!cn";
          query_type = [
            "A"
            "AAAA"
          ];
          server = "dns_fakeip";
        }
        {
          rule_set = "geosite-geolocation-!cn";
          query_type = [
            "CNAME"
          ];
          server = "dns_proxy";
        }
        {
          query_type = [
            "A"
            "AAAA"
            "CNAME"
          ];
          invert = true;
          server = "dns_refused";
          disable_cache = true;
        }
      ];
      final = "dns_direct";
      independent_cache = true;
      fakeip = {
        enabled = true;
        inet4_range = "198.18.0.0/15";
        inet6_range = "fc00::/18";
      };
    };
    route = {
      rule_set = [
        {
          tag = "BlockHttpDNS";
          type = "remote";
          format = "binary";
          url = "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/bm7/BlockHttpDNS.srs";
          download_detour = "proxy";
        }
        {
          tag = "geosite-category-ads-all";
          type = "remote";
          format = "binary";
          url = "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-category-ads-all.srs";
          download_detour = "proxy";
        }
        {
          tag = "geosite-geolocation-!cn";
          type = "remote";
          format = "binary";
          url = "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-geolocation-!cn.srs";
          download_detour = "proxy";
        }
        {
          tag = "geoip-cn";
          type = "remote";
          format = "binary";
          url = "https://raw.githubusercontent.com/SagerNet/sing-geoip/rule-set/geoip-cn.srs";
          download_detour = "proxy";
        }
      ];
      rules = [
        {
          protocol = "dns";
          outbound = "dns-out";
        }
        {
          rule_set = [
            "BlockHttpDNS"
            "geosite-category-ads-all"
          ];
          outbound = "block";
        }
        {
          rule_set = "geosite-geolocation-!cn";
          outbound = "proxy";
        }
        {
          rule_set = "geoip-cn";
          ip_is_private = true;
          domain = [ "www.msftconnecttest.com" "msftconnecttest.com" ];
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
        inet4_address = "172.16.0.1/30";
        inet6_address = "fd00::1/126";
        mtu = 1400;
        auto_route = true;
        strict_route = true;
        stack = "gvisor";
        sniff = true;
        sniff_override_destination = false;
      }
    ];
    outbounds =
      let
        tuicSet = {
          type = "tuic";
          server_port = 443;
          inherit (secrets.sing-box.tuic) uuid password;
          congestion_control = "bbr";
          udp_relay_mode = "native";
          udp_over_stream = false;
          zero_rtt_handshake = false;
          heartbeat = "10s";
          network = "tcp";
          tls = { enabled = true; alpn = [ "h3" ]; };
          tcp_fast_open = true;
        };
        tuicList = [ "cc" "tokyo-1" "tokyo-2" "osaka-1" "osaka-2" ];
      in
      map
        (tag: tuicSet // { inherit tag; server = "${tag}.${secrets.ssl.domain}"; })
        tuicList ++
      [
        {
          tag = "proxy";
          type = "urltest";
          outbounds = tuicList;
          url = "https://www.gstatic.com/generate_204";
          interrupt_exist_connections = false;
        }
        { type = "direct"; tag = "direct"; }
        { type = "block"; tag = "block"; }
        { type = "dns"; tag = "dns-out"; }
      ];
    experimental = {
      cache_file = {
        enabled = true;
        path = "cache.db";
        store_fakeip = true;
      };
      clash_api = {
        external_controller = "0.0.0.0:9090";
        external_ui = "${pkgs.Yacd-meta}";
        secret = "101005";
      };
    };
  };
in

{
  services.sing-box = {
    enable = true;
    settings = lib.mkForce settings;
  };

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };
}

