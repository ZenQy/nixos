{ ... }:

{
  imports = [
    ../vps
    ../vps/nezha-agent.nix
    ../vps/podman.nix
    ../vps/rclone.nix
  ];

  nix.settings.substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
  ];

}
