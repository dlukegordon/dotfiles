{ config, pkgs, lib, ... }:

{
  imports = [ ./general.nix ./plasma.nix ./doom.nix ./librewolf.nix ];

  # The rest of the git configs are in general.nix
  programs.git.userEmail = "luke@valhalla";
}
