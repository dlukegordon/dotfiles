{
  config,
  pkgs,
  pkgsUnstable,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./server/server.nix
    ./server/bitcoin.nix
    ./modules/syncthing.nix
  ];

  networking.hostName = "nidavellir";
}
