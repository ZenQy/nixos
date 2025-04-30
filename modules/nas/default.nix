{ ... }:

{
  imports = [
    ../vps
    ../vps/rclone.nix
    ../vps/nezha-agent.nix
  ];

  nix.settings.substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
  ];

}
