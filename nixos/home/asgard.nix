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
  ];

  # The rest of the git configs are in modules/general.nix
  programs.git.userEmail = "luke@asgard";

  # Swap Super and Alt
  programs.plasma.input.keyboard.options = ["caps:escape" "altwin:swap_lalt_lwin"];
}
