{
  config,
  pkgs,
  pkgsUnstable,
  pkgs2411,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/nvidia.nix
    ./modules/pkgs.nix
    ./modules/stylix.nix
    ./modules/system.nix
  ];

  networking.hostName = "valhalla";

  boot.kernelPackages = pkgs2411.linuxPackages_6_12;
}
