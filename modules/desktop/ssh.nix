{ secrets, ... }:
let
  inherit (builtins)
    attrNames
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

      knownHosts.remote = {
        hostNames = map (host: host.ip) (attrValues hosts);
        publicKey = secrets.openssh.ed25519_pub;
      };
    };
}
