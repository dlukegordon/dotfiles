{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./modules/general.nix
    ./modules/plasma.nix
    ./modules/librewolf.nix
    ./modules/stylix.nix
    ./modules/hyprland.nix
  ];

  # The rest of the git configs are in modules/general.nix
  programs.git.userEmail = "luke@valhalla";
}
