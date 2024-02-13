{ ... }:

{
  services = {

    navidrome = {
      enable = true;
      settings = {
        Address = "0.0.0.0";
        Port = 4533;
        ScanSchedule = "@daily";
        MusicFolder = "/storage/music";
        DefaultLanguage = "zh-Hans";
      };
    };

    aria2 = {
      enable = true;
      extraArguments = "--check-certificate=false";
      downloadDir = "/storage/aria2";
      rpcSecretFile = builtins.toFile "aria2-rpc-token.txt" "";
    };
  };
}
