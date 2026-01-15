{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    networkConfig = {
      Address = secrets.hosts.oect.ipv4.ip;
      Gateway = secrets.hosts.oect.ipv4.gateway;
      DHCP = "ipv6";
    };
  };

  zenith.openlist.enable = true;
  zenith.transmission.enable = true;

  # environment.systemPackages = with pkgs; [
  #   apt-mirror
  # ];
  # environment.etc."apt/mirror.list".text = ''
  #   set base_path         /storage/apt-mirror
  #   set defaultarch       amd64
  #   set nthreads          20
  #   set limit_rate        300m

  #   deb http://archive.kylinos.cn/kylin/KYLIN-ALL 10.1-2403-xc-gjdw main restricted universe multiverse
  #   deb https://archive2.kylinos.cn/deb/kylin/production/PART-V10-SP1/custom/partner/V10-SP1 default all
  # '';

}
