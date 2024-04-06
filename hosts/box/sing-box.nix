{ pkgs, lib, secrets, ... }:

let
  settings = {
    log = { level = "warn"; timestamp = false; };
    dns = {
      servers = [
        {
          tag = "dns_fakeip";
          address = "fakeip";
        }
        {
          tag = "dns_proxy";
          address = "https://1.1.1.1/dns-query";
          address_resolver = "dns_direct";
          strategy = "ipv4_only";
          detour = "proxy";
        }
        {
          tag = "dns_direct";
          address = "223.5.5.5";
          detour = "direct";
        }
      ];
      rules = [
        {
          outbound = "any";
          server = "dns_direct";
        }
        {
          domain_suffix = [
            ".cn"
            "msftconnecttest.com"
          ];
          server = "dns_direct";
        }
        {
          rule_set = "geosite-cn";
          server = "dns_direct";
        }
        {
          rule_set = "geosite-cn";
          invert = true;
          server = "dns_fakeip";
        }
      ];
      final = "dns_proxy";
      independent_cache = true;
      fakeip = {
        enabled = true;
        inet4_range = "198.18.0.0/15";
        inet6_range = "fc00::/18";
      };
    };
    route = {
      geosite.path = "/etc/sing-box/geosite.db";
      geoip.path = "/etc/sing-box/geoip.db";
      rule_set = [
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
      ];
      rules = [
        {
          protocol = "dns";
          outbound = "dns-out";
        }
        {
          rule_set = "geosite-cn";
          outbound = "direct";
        }
        {
          domain_suffix = [
            ".cn"
            "msftconnecttest.com"
          ];
          outbound = "direct";
        }
        {
          rule_set = "geoip-cn";
          ip_is_private = true;
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
        trojanSet = {
          type = "trojan";
          server_port = 443;
          inherit (secrets.sing-box.trojan) password;
          tls = { enabled = true; };
          multiplex = {
            enabled = true;
          };
          transport = {
            type = "ws";
            path = secrets.sing-box.trojan.path;
            max_early_data = 2048;
          };
        };
        trojanList = tuicList ++ [ "natvps-ca" "natvps-jp" "natseek-us" "natseek-jp" ];
      in
      map
        (tag: tuicSet // {
          inherit tag;
          server = "${tag}.${secrets.domain}";
        })
        (map (tag: tag + "-tuic") tuicList) ++
      map
        (tag: trojanSet // {
          inherit tag;
          server = "${tag}.${secrets.domain}";
        })
        (map (tag: tag + "-trojan") trojanList) ++
      [
        {
          tag = "proxy";
          type = "selector";
          outbounds = [ "tuic" "trojan" "direct" ];
        }
        {
          tag = "tuic";
          type = "selector";
          outbounds = map (tag: tag + "-tuic") tuicList;
        }
        {
          tag = "trojan";
          type = "selector";
          outbounds = map (tag: tag + "-trojan") trojanList;
        }
        {
          type = "direct";
          tag = "direct";
        }
        {
          type = "block";
          tag = "block";
        }
        {
          type = "dns";
          tag = "dns-out";
        }
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
        secret = secrets.user.zenith.password;
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

