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

  programs.plasma.powerdevil.AC.powerProfile = "balanced";
  programs.plasma.powerdevil.battery.powerProfile = "balanced";
  programs.plasma.powerdevil.lowBattery.powerProfile = "powerSaving";

  # The rest of the git and jj configs are in modules/general.nix
  programs.git.settings.user.email = "luke@earth";
  programs.jujutsu.settings.user.email = "luke@earth";
}
