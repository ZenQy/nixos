{ pkgs, secrets, ... }:

let
  settings =
    let
      process_name_direct = [
        "transmission-daemon"
      ];
      domain_suffix_proxy = [
        "googleapis.cn"
      ];
      domain_suffix_direct = [
        secrets.domain
        ".cn"
        "allawnfs.com"
        "epicgames.com"
        "msftconnecttest.com"
        "blizzard.com"
        "test-ipv6.com"
        "10155.com"
      ];
    in
    {
      log = {
        level = "warn";
        timestamp = false;
      };
      dns = {
        servers = [
          {
            tag = "dns_fakeip";
            address = "fakeip";
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
            process_name = process_name_direct;
            server = "dns_direct";
          }
          {
            domain_suffix = domain_suffix_proxy;
            server = "dns_fakeip";
          }
          {
            domain_suffix = domain_suffix_direct;
            server = "dns_direct";
          }
          {
            rule_set = "geosite-geolocation-cn@ads";
            server = "dns_fakeip";
          }
          {
            rule_set = "geosite-geolocation-!cn@ads";
            server = "dns_fakeip";
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
        final = "dns_direct";
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
          {
            tag = "geosite-geolocation-cn@ads";
            type = "remote";
            format = "binary";
            url = "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-geolocation-cn@ads.srs";
            download_detour = "proxy";
          }
          {
            tag = "geosite-geolocation-!cn@ads";
            type = "remote";
            format = "binary";
            url = "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-geolocation-!cn@ads.srs";
            download_detour = "proxy";
          }
        ];
        rules = [
          {
            protocol = "dns";
            outbound = "dns-out";
          }
          {
            process_name = process_name_direct;
            outbound = "direct";
          }
          {
            domain_suffix = domain_suffix_proxy;
            outbound = "proxy";
          }
          {
            domain_suffix = domain_suffix_direct;
            ip_is_private = true;
            outbound = "direct";
          }
          {
            rule_set = "geosite-geolocation-cn@ads";
            outbound = "block";
          }
          {
            rule_set = "geosite-geolocation-!cn@ads";
            outbound = "block";
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
            "172.16.0.1/30"
            "fd00::1/126"
          ];
          mtu = 9000;
          auto_route = true;
          strict_route = false;
          sniff = true;
          sniff_override_destination = false;
        }
      ];
      outbounds =
        let
          trojan = {
            type = "trojan";
            server_port = 443;
            inherit (secrets.sing-box.trojan) password;
            tls.enabled = true;
            multiplex.enabled = true;
          };
          tagList = [
            "claw"
            "crbs"
            "osaka-1"
            "osaka-2"
            "tokyo-1"
            "tokyo-2"
            "natvps-ca"
            "natvps-jp"
          ];
        in
        map (
          tag:
          trojan
          // {
            tag = "claw⭢${tag}";
            server = "claw.${secrets.domain}";
            transport = {
              type = "ws";
              path = "/${tag}";
            };
          }
        ) (builtins.filter (x: x != "claw") tagList)
        ++ map (
          tag:
          trojan
          // {
            inherit tag;
            server = "${tag}.${secrets.domain}";
            transport = {
              type = "ws";
              path = "/${tag}";
            };
          }
        ) tagList
        ++ [
          {
            tag = "cloudflare";
            type = "trojan";
            server = "www.visa.com.sg";
            server_port = 443;
            inherit (secrets.sing-box.trojan) password;
            tls = {
              enabled = true;
              server_name = "cf.${secrets.domain}";
            };
            transport = {
              type = "ws";
              headers.Host = "cf.${secrets.domain}";
              path = "/8PtaCVX69w3a4X";
            };
          }
          {
            tag = "proxy";
            type = "selector";
            outbounds =
              tagList
              ++ map (tag: "claw⭢${tag}") (builtins.filter (x: x != "claw") tagList)
              ++ [
                "cloudflare"
                "direct"
              ];
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
          external_ui = "${pkgs.metacubexd}";
        };
      };
    };
in

{
  services.sing-box = {
    enable = true;
    inherit settings;
  };

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };
}
