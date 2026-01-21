{ ... }:

{
  imports = [
    ../vps
    ../vps/nezha-agent.nix
    ../vps/openlist.nix
    ../vps/podman.nix
    ../vps/rclone.nix

    ../desktop/ssh.nix
  ];

  nix.settings.substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
  ];

  networking.nameservers = [
    "223.5.5.5"
    "119.29.29.29"
  ];

}
