{ config, secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network =
    let
      host = config.networking.hostName;
      cfg = secrets.hosts."${host}";
    in
    {
      netdevs.warp0 = {
        netdevConfig = {
          Name = "warp0";
          Kind = "wireguard";
          MTUBytes = 1280;
        };
        wireguardConfig = {
          PrivateKeyFile = builtins.toFile "private.key" cfg.warp.PrivateKey;
        };
        wireguardPeers = [
          {
            PublicKey = "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=";
            Endpoint = "162.159.192.1:2408";
            AllowedIPs = "::/0";
            PersistentKeepalive = 25;
          }
        ];
      };

      networks.warp0 = {
        name = "warp0";
        address = [ cfg.warp.Address ];
        routes = [ { Destination = "::/0"; } ];
      };

      networks.eth0 = {
        name = "eth0";
        networkConfig.DHCP = true;
      };
    };
}
