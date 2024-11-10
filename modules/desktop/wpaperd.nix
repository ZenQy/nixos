{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wpaperd
  ];
}
