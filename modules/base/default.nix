{ pkgs, secrets, ... }:


{
  system.stateVersion = "24.05";
  # nix
  nix = {
    # optimise.automatic = true;
    # gc.automatic = true;
    gc.options = "--delete-older-than 7d";
    # package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      allow-import-from-derivation = true
    '';
    settings.trusted-users = [ "root" "nixos" ];
    settings.substituters = [ secrets.cachix.cacheURL ];
    settings.trusted-public-keys = [ secrets.cachix.public-key ];
  };
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };
  # i18n
  time.timeZone = "Asia/Shanghai";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  };

  powerManagement.enable = false;

  # git
  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
      user = {
        email = "zenqy.qin@gmail.com";
        name = "ZenQy";
      };
      pull.rebase = true;
    };
    package = pkgs.git;
  };

  # nano
  programs.nano = {
    nanorc = ''
      set autoindent     
      set casesensitive  
      set linenumbers          
      set nohelp         
      set smarthome              
      set tabsize 2      
      set tabstospaces   
    '';
    syntaxHighlight = true;
  };

  # bash
  programs.bash.promptInit = ''
    PROMPT_COLOR="1;31m"
    let $UID && PROMPT_COLOR="1;32m"
    PS1="\[\033[$PROMPT_COLOR\][\u@\h:\w]\\$\[\033[0m\] "
  '';

  environment.systemPackages = with pkgs; [
    fastfetch
    jq
  ];

}
