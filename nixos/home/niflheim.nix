{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./modules/doom.nix
    ./modules/general.nix
    ./modules/plasma.nix
    ./modules/librewolf.nix
  ];

  # The rest of the git configs are in modules/general.nix
  programs.git.userEmail = "luke@niflheim";
}
