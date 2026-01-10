{
  config,
  pkgs,
  pkgsUnstable,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/nvidia.nix
    ./modules/pkgs.nix
    ./modules/system.nix
  ];

  networking.hostName = "valhalla";

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
