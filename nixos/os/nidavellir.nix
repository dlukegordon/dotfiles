{
  config,
  pkgs,
  pkgsUnstable,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/server.nix
    ./modules/bitcoin.nix
  ];

  networking.hostName = "nidavellir";
}
