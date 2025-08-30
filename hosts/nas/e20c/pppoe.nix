{ secrets, ... }:

{

  services.pppd = {
    enable = true;
    peers.pppoe.config = ''
      plugin pppoe.so eth0

      name "${secrets.pppoe.username}"
      password "${secrets.pppoe.password}"

      persist
      maxfail 0
      holdoff 5

      noipdefault
      defaultroute
    '';
  };

}
