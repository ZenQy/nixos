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

  security.sudo.enable = false;
  security.sudo-rs.enable = true;
}
