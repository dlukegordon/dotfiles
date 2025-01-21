{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/nvidia.nix
    ./modules/pkgs.nix
    ./modules/system.nix
    ./modules/xkeysnail.nix
  ];

  networking.hostName = "niflheim";
}
