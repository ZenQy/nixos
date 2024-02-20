{ secrets, ... }:

{
  users.users = {
    nixos = {
      home = "/home/nixos";
      createHome = true;
      isNormalUser = true;
      description = "ZenQy Qin";
      group = "wheel";
      password = secrets.user.zenith.password;
    };
    root.password = secrets.user.root.password;
  };
}
