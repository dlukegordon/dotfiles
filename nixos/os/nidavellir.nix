{
  config,
  pkgs,
  pkgsUnstable,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./server/server.nix
    ./server/bitcoin.nix
  ];

  networking.hostName = "nidavellir";
}
