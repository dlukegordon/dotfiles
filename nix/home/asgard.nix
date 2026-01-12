{
  config,
  pkgs,
  pkgsUnstable,
  lib,
  ...
}:
{
  imports = [
    ./modules/general.nix
    ./modules/plasma.nix
  ];

  # The rest of the git and jj configs are in modules/general.nix
  programs.git.settings.user.email = "luke@asgard";
  programs.jujutsu.settings.user.email = "luke@asgard";
}
