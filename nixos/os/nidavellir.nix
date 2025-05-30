{
  config,
  pkgs,
  pkgsUnstable,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/server.nix
  ];

  networking.hostName = "nidavellir";
}
