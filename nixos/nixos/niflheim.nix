{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix ./system.nix ./pkgs.nix ./xkeysnail.nix ];

  networking.hostName = "niflheim";
}
