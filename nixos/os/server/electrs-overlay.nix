{config, pkgs, options, lib, ...}:
let
  eachElectrs = config.services.electrs;

  electrsOpts = { name, ... }: {
    options = {
      enable = lib.mkEnableOption "Electrs daemon";
      electrum_rpc_addr = lib.mkOption {
        type = lib.types.str;
        default = "127.0.0.1:50001";
        example = "127.0.0.1:50001";
        description = ''
          Defines address:port of the electrum rpc server
        '';
      };
      log_level = lib.mkOption {
        type = lib.types.str;
        default = "INFO";
        example = "DEBUG";
        description = ''
          Log level of the service, overriding RUST_LOG
        '';
      };
      daemon_rpc_addr = lib.mkOption {
        type = lib.types.str;
        default = "";
        example = "127.0.0.1:8334";
        description = ''
          Defines address:port of the appropriate bitcoind instance
        '';
      };
      db_dir = lib.mkOption {
        type = lib.types.str;
        default = "/var/lib/electrs-${name}";
        example = "/var/lib/electrs-mainnet";
      };
      cookie_file = lib.mkOption {
        type = lib.types.str;
        default = "/var/lib/bitcoind-${name}/.cookie";
        example = "/var/lib/bitcoind-mainnet/.cookie";
      };
      network = lib.mkOption {
        type = lib.types.str;
        default = "bitcoin";
        example = "testnet";
        description = ''
          This option defines Bitcoin network type to work with.
          one of 'bitcoin', 'testnet', 'regtest' or 'signet'
        '';
      };
      user = lib.mkOption {
        type = lib.types.str;
        default = "electrs-${name}";
        example = "electrs-mainnet";
        description = ''
          The user to run the service as
        '';
      };
      group = lib.mkOption {
        type = lib.types.str;
        default = "bitcoind-${name}";
        example = "bitcoind-mainnet";
        description = ''
          The group to run the service as
        '';
      };
    };
  };

  electrs_instance = electrsName: cfg:
    # define systemd service for electrs
    lib.nameValuePair "electrs-${electrsName}" {
      wantedBy = [ "multi-user.target" ];
      after = [ "network-setup.service" "bitcoind-${electrsName}.service" ];
      requires = [ "network-setup.service" "bitcoind-${electrsName}.service" ];
      serviceConfig = {
        User = cfg.user;
        Group = cfg.group;
        Type = "simple";
      };
      path = with pkgs; [ electrs ];
      script = ''
        electrs \
          --electrum-rpc-addr="${cfg.electrum_rpc_addr}" \
          --log-filters="${cfg.log_level}" \
          --db-dir "${cfg.db_dir}" \
          --cookie-file ${cfg.cookie_file} \
          --network ${cfg.network} \
          ${lib.optionalString (lib.stringLength cfg.daemon_rpc_addr > 0) "--daemon-rpc-addr ${cfg.daemon_rpc_addr}"}
      '';
    };
in
{
  options.services.electrs = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule electrsOpts);
    default = {};
    description = "One or more electrs instances";
  };

  config = lib.mkIf (eachElectrs != {}) {
    environment.systemPackages = with pkgs; [
      electrs
    ];

    systemd.services = lib.mapAttrs' electrs_instance eachElectrs;

    systemd.tmpfiles.rules = lib.mapAttrsToList (name: cfg: 
      "d '${cfg.db_dir}' 0770 ${cfg.user} ${cfg.group} - -"
    ) eachElectrs;

    users.users = lib.mkMerge (lib.mapAttrsToList (name: cfg: {
      ${cfg.user} = {
        name = cfg.user;
        group = cfg.group;
        description = "Electrs daemon user";
        home = cfg.db_dir;
        isSystemUser = true;
      };
    }) eachElectrs);
  };
}
