{ ... }:

{
  services.adguardhome = {
    enable = true;
    settings = {
      users = [
        {
          name = "root";
          password = "$2a$10$TeNbO10.lFaY6V/GPda9GejiBw5A98.f8JWwgndncmPa7i/CMEVNW";
        }
      ];
      theme = "auto";
      language = "zh-cn";
      dns = {
        bind_hosts = [ "0.0.0.0" ];
        port = 53;
        upstream_mode = "load_balance";
        upstream_dns = [
          "https://dns.alidns.com/dns-query"
          "https://dns.pub/dns-query"
        ];
        bootstrap_dns = [ "223.5.5.5" ];
      };
      user_rules = [
        # B站
        "||mcdn.bilivideo.cn^"
        "||mcdn.bilivideo.com^"
        "||ppio.bilivideo.com^"
        "||kodo.bilivideo.com^"
        "||mountaintoys.cn^"
        "||szbdyd.com^"
        # 腾讯
        "||hcdn.video.qq.com^"
        "||pcdn.video.qq.com^"
        "||vodlive.qq.com^"
        "||iwan-s.video.qq.com^"
        "||gdt.qq.com^"
        "||cm.l.qq.com^"
        "||isure6.stream.qqmusic.qq.com^"
        # 爱奇艺
        "||hcdn.qiyi.com^"
        "||pdata.video.qiyi.com^"
        "||cachecdn.v.iqiyi.com^"
        "||meta-cdn.video.iq.com^"
        "||tpa-hcdn.iqiyi.com^"
        "||data6.video.iqiyi.com^"
        # 优酷
        "|atm.youku.com^"
        "|Fvid.atm.youku.com^"
        "|html.atm.youku.com^"
        "|valb.atm.youku.com^"
        "|valf.atm.youku.com^"
        "|static.atm.youku.com^"
        "|valc.atm.youku.com^"
        # 字节
        "||pull-rtmp-l11.ixigua.com^"
        "||push-rtmp-l1.ixigua.com^"
        "||pull-hs-f5-hot.flive.douyincdn.com^"
        # 斗鱼
        "||p2p.douyucdn.cn^"
        # 酷狗
        "||trackercdn.kugou.com^"
        "||mobiletrackercdn.kugou.com^"
        "||d.kugou.com^"
        # 网易云
        "||163jiasu.com^"
        "||sf.163.com^"
        # 其他
        "||p-cdn.com^"
        "||pscdn.co^"
        "||p.scdn.co^"
      ];
      filtering.rewrites = [
        {
          domain = "*.lan";
          answer = "10.0.0.12";
          enabled = true;
        }
      ];
    };
  };
}
