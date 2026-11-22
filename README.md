# nixos flakes

一些nix命令

```nix
nix repl nixpkgs
nix eval .#nixosConfigurations.<machine>.config.system.build.toplevel
nix profile diff-closures --profile /nix/var/nix/profiles/system
nix log $(realpath result)

lib.generators.toPretty {} s

# 切换到特定世代
sudo /nix/var/nix/profiles/system-61-link/bin/switch-to-configuration switch
```

根据路由器端`sing-box`配置,生成手机端配置

```bash
settings=$(nix eval --json .#nixosConfigurations.e20c.config.services.sing-box.settings)
# 路由器
echo $settings | jq "del(.inbounds.[].include_package)" > sing-box.json
# 手机
echo $settings | \
  jq "del(.inbounds.[].include_mac_address)" | \
  jq '(.dns.servers.[] | select (.server == "127.0.0.1").server) = "223.5.5.5"' | \
  jq '(.route.rules.[] | select (.process_name)) = {"ip_cidr":"10.0.0.0/24","network_type":"cellular","outbound":"tailscale"}' | \
  jq ".endpoints.[].accept_routes = true" | \
  jq "del(.endpoints.[].advertise_routes)" | \
  jq "del(.services)" > sing-box.json
```
