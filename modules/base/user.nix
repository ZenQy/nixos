{ secrets, ... }:

{
  users.users = {
    nixos = {
      home = "/home/nixos";
      createHome = true;
      isNormalUser = true;
      description = "ZenQy Qin";
      group = "wheel";
      password = secrets.user.password.zenith;
    };
    root.password = secrets.user.password.root;
  };
}
