{ ... }:

{
  services.adguardhome = {
    enable = true;
    host = "127.0.0.1";
    port = 3000;
    settings = {
      users = [
        {
          name = "root";
          password = "$2y$10$dwn0hTYoECQMZETBErGlzOId2VANOVsPHsuH13TM/8KnysM5Dh/ve";
        }
      ];
    };
  };
}
