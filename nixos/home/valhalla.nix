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
  programs.git.userEmail = "luke@valhalla";
  programs.jujutsu.settings.user.email = "luke@valhalla";
}
