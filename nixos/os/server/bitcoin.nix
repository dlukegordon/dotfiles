{
  config,
  pkgs,
  pkgsUnstable,
  ...
}: {
  services.bitcoind.mainnet = {
    enable = true;
    dbCache = 4096;
    extraConfig = ''
      txindex=1
      rpcbind=0.0.0.0
      rpcallowip=127.0.0.1
      rpcallowip=192.168.0.0/16
    '';
  };
}
