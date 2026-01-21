{ secrets, ... }:
let
  inherit (builtins)
    attrValues
    concatStringsSep
    mapAttrs
    ;
in
{
  programs.ssh =
    let
      inherit (secrets.openssh) hosts;
    in
    {
      extraConfig = concatStringsSep "\n" (
        attrValues (
          mapAttrs (k: v: ''
            Host ${k}
              HostName ${v.ip}
              User root
              Port ${toString v.port}
          '') hosts
        )
      );

      knownHosts = {
        vps = {
          hostNames = map (host: host.ip) (attrValues hosts);
          publicKey = secrets.openssh.ed25519_pub;
        };
        github = {
          hostNames = [ "github.com" ];
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
        };
      };
    };
}
