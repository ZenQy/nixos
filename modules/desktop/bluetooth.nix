{ ... }:

{
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        DiscoverableTimeout = 0;
      };
    };
    input = {
      General = {
        ClassicBondedOnly = true;
        IdleTimeout = 30;
      };
    };
  };
}

