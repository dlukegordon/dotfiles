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
  ];

  # The rest of the git and jj configs are in modules/general.nix
  programs.git.userEmail = "luke@asgard";
  programs.jujutsu.settings.user.email = "luke@asgard";
}
