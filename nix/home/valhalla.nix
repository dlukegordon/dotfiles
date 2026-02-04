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
    ./modules/whisper-dictate.nix
  ];

  programs.plasma.powerdevil.AC.powerProfile = "performance";

  # The rest of the git and jj configs are in modules/general.nix
  programs.git.settings.user.email = "luke@earth";
  programs.jujutsu.settings.user.email = "luke@earth";
}
