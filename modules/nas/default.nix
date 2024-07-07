{ ... }:

{

  imports = [
    ../server
    ../server/nezha-agent.nix
  ];

  nix.settings.substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
  ];

}
