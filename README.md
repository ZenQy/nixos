# nixos flakes

一些nix命令

```nix
nix repl nixpkgs
nix eval .#nixosConfigurations.<machine>.config.system.build.toplevel
nix profile diff-closures --profile /nix/var/nix/profiles/system
nix log $(realpath result)

lib.generators.toPretty {} s
```

根据路由器端`sing-box`配置,生成手机端配置

```bash
inbound="{\"address\":[\"172.18.0.1/24\",\"fdfe:dcba:9876::1/64\"],\"auto_route\":true,\"include_package\":[\"InfinityLoop1309.NewPipeEnhanced\",\"app.aiaw\",\"cn.jimex.dict\",\"com.aistra.hail\",\"com.aurora.store\",\"com.deskangel.daremote\",\"com.google.android.gms\",\"com.ichi2.anki\",\"com.mmbox.xbrowser.pro\",\"com.x8bit.bitwarden\",\"com.xbrowser.play\",\"io.legado.app.release\",\"io.legato.kazusa\",\"mark.via\",\"mark.via.gp\",\"me.bmax.apatch\",\"org.telegram.messenger\",\"pro.cubox.androidapp\",\"top.achatbot.aichat\",\"xyz.chatboxapp.chatbox\"],\"mtu\":1500,\"stack\":\"gvisor\",\"strict_route\":false,\"tag\":\"tun\",\"type\":\"tun\"}"
settings=$(nix eval --json .#nixosConfigurations.e20c.config.services.sing-box.settings)
echo $settings | \
  jq ".inbounds = [$inbound]" | \
  jq '(.dns.servers.[] | select (.server == "127.0.0.53").server) = "223.5.5.5"' | \
  jq '(.route.rules.[] | select (.process_name == "AdGuardHome")) = {"ip_cidr":"10.0.0.0/24","network_type":"cellular","outbound":"tailscale"}' | \
  jq ".endpoints.[].accept_routes = true" | \
  jq "del(.endpoints.[].advertise_routes)" | \
  jq "del(.experimental.clash_api)" \
  > sing-box.json
```
