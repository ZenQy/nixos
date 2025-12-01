{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mpv
  ];

  environment.etc."mpv/mpv.conf".text = ''
    alang=chi,zh-CN,sc,chs,zh-TW,tc,cht,eng,en
    force-window=yes
    hwdec-codecs=all
    hwdec=auto
    profile=gpu-hq
    slang=chi,zh-CN,sc,chs,zh-TW,tc,cht,eng,en
    speed=2.0
    sub-codepage=UTF-8
    user-agent=Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36
    vo=gpu
    ytdl-format=bestvideo+bestaudio

    autocreate-playlist=filter
    directory-filter-types=video,audio
    prefetch-playlist=yes
    directory-mode=ignore
  '';
}
