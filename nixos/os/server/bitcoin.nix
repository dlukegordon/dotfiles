{
  config,
  pkgs,
  pkgsUnstable,
  ...
}:
{
  imports = [
    ./electrs-overlay.nix
    ./mempool-overlay.nix
  ];

  services.bitcoind.mainnet = {
    enable = true;
    dbCache = 4096;
    extraConfig = ''
      server=1
      txindex=1
      rpcbind=0.0.0.0
      rpcallowip=127.0.0.1
      rpcallowip=192.168.0.0/16
      rpcallowip=172.18.0.0/16
    '';
  };

  services.electrs.mainnet = {
    enable = true;
    electrum_rpc_addr = "0.0.0.0:50001";
  };

  services.mempool.mainnet = {
    enable = true;
  };

  networking.firewall.allowedTCPPorts = [
    80
    8332
    8333
    50001
  ];
}
