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
      rpcallowip=172.18.0.0/16
    '';
  };

  services.electrs.mainnet = {
    enable = true;
    electrum_rpc_addr = "0.0.0.0:50001";
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      mempool-web = {
        image = "mempool/frontend:latest";
        user = "${toString config.users.users.bitcoind-mainnet.uid}:${toString config.users.groups.bitcoind-mainnet.gid}";
        environment = {
          FRONTEND_HTTP_PORT = "8080";
          BACKEND_MAINNET_HTTP_HOST = "mempool-api";
        };
        ports = [
          "80:8080"
        ];
        cmd = [ "./wait-for" "mempool-db:3306" "--timeout=720" "--" "nginx" "-g" "daemon off;" ];
        dependsOn = [ "mempool-api" ];
        extraOptions = [
          "--network=mempool-net"
        ];
      };

      mempool-api = {
        image = "mempool/backend:latest";
        user = "${toString config.users.users.bitcoind-mainnet.uid}:${toString config.users.groups.bitcoind-mainnet.gid}";
        environment = {
          MEMPOOL_BACKEND = "electrum";
          ELECTRUM_HOST = "172.17.0.1"; # Docker gateway ip
          ELECTRUM_PORT = "50001";
          ELECTRUM_TLS_ENABLED = "false";
          CORE_RPC_HOST = "172.17.0.1";
          CORE_RPC_PORT = "8332";
          CORE_RPC_COOKIE = "true";
          CORE_RPC_COOKIE_PATH = "/backend/.cookie";
          DATABASE_ENABLED = "true";
          DATABASE_HOST = "mempool-db";
          DATABASE_DATABASE = "mempool";
          DATABASE_USERNAME = "mempool";
          DATABASE_PASSWORD = "mempool";
          STATISTICS_ENABLED = "true";
        };
        volumes = [
          "/var/lib/mempool/data:/backend/cache"
          "/var/lib/bitcoind-mainnet/.cookie:/backend/.cookie:ro"
        ];
        cmd = [ "./wait-for-it.sh" "mempool-db:3306" "--timeout=720" "--strict" "--" "./start.sh" ];
        dependsOn = [ "mempool-db" ];
        extraOptions = [
          "--network=mempool-net"
        ];
      };

      mempool-db = {
        image = "mariadb:10.5.21";
        user = "${toString config.users.users.bitcoind-mainnet.uid}:${toString config.users.groups.bitcoind-mainnet.gid}";
        environment = {
          MYSQL_DATABASE = "mempool";
          MYSQL_USER = "mempool";
          MYSQL_PASSWORD = "mempool";
          MYSQL_ROOT_PASSWORD = "admin";
        };
        volumes = [
          "/var/lib/mempool/mysql:/var/lib/mysql"
        ];
        extraOptions = [
          "--network=mempool-net"
        ];
      };
    };
  };

  systemd.services.init-mempool-network = {
    description = "Create mempool docker network";
    after = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.docker}/bin/docker network ls | grep mempool-net || \
      ${pkgs.docker}/bin/docker network create mempool-net
    '';
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/mempool 0755 root root -"
    "d /var/lib/mempool/data 0755 ${toString config.users.users.bitcoind-mainnet.uid} ${toString config.users.groups.bitcoind-mainnet.gid} -"
    "d /var/lib/mempool/mysql 0755 ${toString config.users.users.bitcoind-mainnet.uid} ${toString config.users.groups.bitcoind-mainnet.gid} -"
  ];

  networking.firewall.allowedTCPPorts = [80 8332 8333 50001];
}
