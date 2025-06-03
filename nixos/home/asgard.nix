{
  config,
  pkgs,
  pkgsUnstable,
  lib,
  ...
}: {
  imports = [
    ./modules/general.nix
    ./modules/plasma.nix
    ./modules/stylix.nix
    ./modules/wm.nix
  ];

  # The rest of the git and jj configs are in modules/general.nix
  programs.git.userEmail = "luke@asgard";
  programs.jujutsu.settings.user.email = "luke@asgard";

  # Swap Super and Alt
  programs.plasma.input.keyboard.options = ["caps:escape" "altwin:swap_lalt_lwin"];
}
