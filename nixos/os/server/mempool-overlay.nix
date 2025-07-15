{
  config,
  pkgs,
  options,
  lib,
  ...
}:
let
  eachMempool = config.services.mempool;
  mempoolOpts =
    { name, ... }:
    {
      options = {
        enable = lib.mkEnableOption "Mempool service";

        frontend = {
          port = lib.mkOption {
            type = lib.types.port;
            default = 80;
            description = "Port for the mempool frontend";
          };
          image = lib.mkOption {
            type = lib.types.str;
            default = "mempool/frontend:latest";
            description = "Docker image for mempool frontend";
          };
        };

        backend = {
          electrum_host = lib.mkOption {
            type = lib.types.str;
            default = "172.17.0.1";
            description = "Electrum server host";
          };
          electrum_port = lib.mkOption {
            type = lib.types.str;
            default = "50001";
            description = "Electrum server port";
          };
          core_rpc_host = lib.mkOption {
            type = lib.types.str;
            default = "172.17.0.1";
            description = "Bitcoin Core RPC host";
          };
          core_rpc_port = lib.mkOption {
            type = lib.types.str;
            default = "8332";
            description = "Bitcoin Core RPC port";
          };
          image = lib.mkOption {
            type = lib.types.str;
            default = "mempool/backend:latest";
            description = "Docker image for mempool backend";
          };
        };

        database = {
          name = lib.mkOption {
            type = lib.types.str;
            default = "mempool";
            description = "Database name";
          };
          username = lib.mkOption {
            type = lib.types.str;
            default = "mempool";
            description = "Database username";
          };
          password = lib.mkOption {
            type = lib.types.str;
            default = "mempool";
            description = "Database password";
          };
          root_password = lib.mkOption {
            type = lib.types.str;
            default = "admin";
            description = "Database root password";
          };
          image = lib.mkOption {
            type = lib.types.str;
            default = "mariadb:10.5.21";
            description = "Docker image for database";
          };
        };

        data_dir = lib.mkOption {
          type = lib.types.str;
          default = "/var/lib/mempool-${name}";
          description = "Data directory for mempool";
        };

        cookie_file = lib.mkOption {
          type = lib.types.str;
          default = "/var/lib/bitcoind-${name}/.cookie";
          description = "Path to Bitcoin Core cookie file";
        };

        user = lib.mkOption {
          type = lib.types.str;
          default = "bitcoind-${name}";
          description = "User to run the service as";
        };

        group = lib.mkOption {
          type = lib.types.str;
          default = "bitcoind-${name}";
          description = "Group to run the service as";
        };

        network_name = lib.mkOption {
          type = lib.types.str;
          default = "mempool-${name}-net";
          description = "Docker network name for mempool containers";
        };
      };
    };

  mempool_containers = mempool_name: cfg: {
    "mempool-${mempool_name}-web" = {
      image = cfg.frontend.image;
      user = "${toString config.users.users.${cfg.user}.uid}:${
        toString config.users.groups.${cfg.group}.gid
      }";
      environment = {
        FRONTEND_HTTP_PORT = "8080";
        BACKEND_MAINNET_HTTP_HOST = "mempool-${mempool_name}-api";
      };
      ports = [
        "${toString cfg.frontend.port}:8080"
      ];
      cmd = [
        "./wait-for"
        "mempool-${mempool_name}-db:3306"
        "--timeout=60"
        "--"
        "nginx"
        "-g"
        "daemon off;"
      ];
      dependsOn = [ "mempool-${mempool_name}-api" ];
      extraOptions = [
        "--network=${cfg.network_name}"
      ];
    };

    "mempool-${mempool_name}-api" = {
      image = cfg.backend.image;
      user = "${toString config.users.users.${cfg.user}.uid}:${
        toString config.users.groups.${cfg.group}.gid
      }";
      environment = {
        MEMPOOL_BACKEND = "electrum";
        ELECTRUM_HOST = cfg.backend.electrum_host;
        ELECTRUM_PORT = cfg.backend.electrum_port;
        ELECTRUM_TLS_ENABLED = "false";
        CORE_RPC_HOST = cfg.backend.core_rpc_host;
        CORE_RPC_PORT = cfg.backend.core_rpc_port;
        CORE_RPC_COOKIE = "true";
        CORE_RPC_COOKIE_PATH = "/backend/.cookie";
        DATABASE_ENABLED = "true";
        DATABASE_HOST = "mempool-${mempool_name}-db";
        DATABASE_DATABASE = cfg.database.name;
        DATABASE_USERNAME = cfg.database.username;
        DATABASE_PASSWORD = cfg.database.password;
        STATISTICS_ENABLED = "true";
      };
      volumes = [
        "${cfg.data_dir}/data:/backend/cache"
        "${cfg.cookie_file}:/backend/.cookie:ro"
      ];
      cmd = [
        "./wait-for-it.sh"
        "mempool-${mempool_name}-db:3306"
        "--timeout=60"
        "--strict"
        "--"
        "./start.sh"
      ];
      dependsOn = [ "mempool-${mempool_name}-db" ];
      extraOptions = [
        "--network=${cfg.network_name}"
      ];
    };

    "mempool-${mempool_name}-db" = {
      image = cfg.database.image;
      user = "${toString config.users.users.${cfg.user}.uid}:${
        toString config.users.groups.${cfg.group}.gid
      }";
      environment = {
        MYSQL_DATABASE = cfg.database.name;
        MYSQL_USER = cfg.database.username;
        MYSQL_PASSWORD = cfg.database.password;
        MYSQL_ROOT_PASSWORD = cfg.database.root_password;
      };
      volumes = [
        "${cfg.data_dir}/mysql:/var/lib/mysql"
      ];
      extraOptions = [
        "--network=${cfg.network_name}"
      ];
    };
  };

  mempool_network_service =
    mempool_name: cfg:
    lib.nameValuePair "init-mempool-${mempool_name}-network" {
      description = "Create mempool-${mempool_name} docker network";
      after = [ "docker.service" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig.Type = "oneshot";
      script = ''
        ${pkgs.docker}/bin/docker network ls | grep ${cfg.network_name} || \
        ${pkgs.docker}/bin/docker network create ${cfg.network_name}
      '';
    };

  mempool_tmpfiles = mempool_name: cfg: [
    "d ${cfg.data_dir} 0755 root root -"
    "d ${cfg.data_dir}/data 0755 ${toString config.users.users.${cfg.user}.uid} ${
      toString config.users.groups.${cfg.group}.gid
    } -"
    "d ${cfg.data_dir}/mysql 0755 ${toString config.users.users.${cfg.user}.uid} ${
      toString config.users.groups.${cfg.group}.gid
    } -"
  ];

in
{
  options.services.mempool = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule mempoolOpts);
    default = { };
    description = "One or more mempool instances";
  };

  config = lib.mkIf (eachMempool != { }) {
    virtualisation.oci-containers = {
      backend = "docker";
      containers = lib.mkMerge (lib.mapAttrsToList mempool_containers eachMempool);
    };

    systemd.services = lib.mkMerge [
      (lib.mapAttrs' mempool_network_service eachMempool)
    ];

    systemd.tmpfiles.rules = lib.flatten (lib.mapAttrsToList mempool_tmpfiles eachMempool);
  };
}
