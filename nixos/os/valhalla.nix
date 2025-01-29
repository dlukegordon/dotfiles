{
  config,
  pkgs,
  pkgsUnstable,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/nvidia.nix
    ./modules/pkgs.nix
    ./modules/stylix.nix
    ./modules/system.nix
    ./modules/xkeysnail.nix
  ];

  networking.hostName = "valhalla";
}
