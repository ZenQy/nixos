{
  config,
  secrets,
  pkgs,
  ...
}:

{
  services.openssh = {
    enable = true;
    ports = [ secrets.openssh.port ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };
  environment.etc = {
    "ssh/ssh_host_ed25519_key".mode = "0600";
    "ssh/ssh_host_ed25519_key".text = secrets.openssh.ed25519_key;
    "ssh/ssh_host_ed25519_key.pub".text =
      secrets.openssh.ed25519_pub + " root@" + config.networking.hostName;
  };
  users.users =
    let
      opensshKeys = {
        openssh.authorizedKeys.keys = [
          secrets.openssh.key
        ];
      };
    in
    {
      root = opensshKeys;
      nixos = opensshKeys;
    };

  boot.kernelParams = [
    "audit=0"
    "net.ifnames=0"
  ];
  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "cake";
    "net.core.rmem_default" = 2097152;
    "net.core.rmem_max" = 208338944;
    "net.core.wmem_default" = 2097152;
    "net.core.wmem_max" = 208338944;
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_rmem" = "16384 2097152 208338944";
    "net.ipv4.tcp_wmem" = "16384 2097152 208338944";
    # 国内环境关闭 ECN，防止中间设备丢包
    "net.ipv4.tcp_ecn" = 0;
    # 提高 BBR 测速精度
    "net.ipv4.tcp_timestamps" = 1;
    # 开启选择性确认
    "net.ipv4.tcp_sack" = 1;
    # 视频暂停后重播不降速
    "net.ipv4.tcp_slow_start_after_idle" = 0;
    # 自动探测链路 MTU 防止丢包
    "net.ipv4.tcp_mtu_probing" = 1;
    # Keepalive（长连接场景）
    "net.ipv4.tcp_keepalive_time" = 300;
    "net.ipv4.tcp_keepalive_intvl" = 30;
    "net.ipv4.tcp_keepalive_probes" = 5;
  };

  environment.systemPackages = with pkgs; [
    iperf3
  ];

  documentation.nixos.enable = false;
}
