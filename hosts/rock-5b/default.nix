{ pkgs, secrets, ... }:
with builtins;

let lan = "enP4p1s0";
in

{
  imports = [
    ./hardware.nix
  ];
  nix.settings.substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
  ];
  nixpkgs.hostPlatform.system = "aarch64-linux";
  boot.kernelPackages = pkgs.linuxPackages_latest;

  systemd.network.networks.default = {
    name = lan;
    address = [ "10.0.0.8/24" ];
    gateway = [ "10.0.0.1" ];
    dns = [ "114.114.114.114" ];
    DHCP = "no";
  };


  services = {
    syncthing = {
      enable = true;
      user = "nixos";
      group = "wheel";
      guiAddress = "0.0.0.0:8384";
    };

    dae =
      let node = concatStringsSep "\n" (map (host: "${host}: 'tuic://${secrets.sing-box.tuic.uuid}:${secrets.sing-box.tuic.password}@${host}.${secrets.ssl.domain}:443/?congestion_control=bbr&udp_relay_mode=native&alpn=h3#cc'") [ "cc" "osaka-1" "osaka-2" "tokyo-1" "tokyo-2" ]);
      in {
        enable = true;
        config = ''
          global {
            # 绑定到 LAN 和/或 WAN 接口。将下述接口替换成你自己的接口名。
            lan_interface: ${lan}
            wan_interface: auto # 使用 "auto" 自动侦测 WAN 接口。

            log_level: info
            allow_insecure: false
            auto_config_kernel_parameter: false
          }

          subscription {
            # 在下面填入你的订阅链接。
          }

          node {
        '' + node + ''
          }

          # 对于中国大陆域名使用 alidns，其他使用 googledns 查询。
          dns {
            upstream {
              googledns: 'tcp+udp://dns.google.com:53'
              alidns: 'udp://dns.alidns.com:53'
            }
            routing {
              # 根据 DNS 查询，决定使用哪个 DNS 上游。
              # 按由上到下的顺序匹配。
              request {
                # 对于中国大陆域名使用 alidns，其他使用 googledns 查询。
                qname(geosite:cn) -> alidns
                # fallback 意为 default。
                fallback: googledns
              }
            }
          }

          group {
            proxy {
              #filter: name(keyword: HK, keyword: SG)
              policy: min_moving_avg
            }
          }

          # 更多的 Routing 样例见 https://github.com/daeuniverse/dae/blob/main/docs/en/configuration/routing.md
          routing {
            dip(geoip:private) -> direct
            dip(geoip:cn) -> direct
            domain(geosite:cn) -> direct

            fallback: proxy
          }
        '';
      };
  };

  boot.kernel.sysctl = {
    "net.ipv4.conf.${lan}.forwarding" = 1;
    "net.ipv6.conf.${lan}.forwarding" = 1;
    "net.ipv4.conf.${lan}.send_redirects" = 0;
    "net.ipv4.ip_forward" = 1;
  };
}
