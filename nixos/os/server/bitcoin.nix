{
  config,
  pkgs,
  pkgsUnstable,
  ...
}: {
  imports = [
    ./electrs-overlay.nix
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
    '';
    # Allow other services in group to access the cookie
    extraCmdlineOptions = [ "-startupnotify='chmod g+r /var/lib/bitcoind-mainnet/.cookie'" ];
  };

  services.electrs.mainnet = {
    enable = true;
    electrum_rpc_addr = "0.0.0.0:50001";
  };

  networking.firewall.allowedTCPPorts = [50001];
}
