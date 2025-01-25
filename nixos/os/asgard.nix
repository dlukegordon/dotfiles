{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/pkgs.nix
    ./modules/system.nix
    ./modules/xkeysnail.nix
  ];

  networking.hostName = "asgard";

  # Fingerprint reader
  systemd.services.fprintd = {
    wantedBy = ["multi-user.target"];
    serviceConfig.Type = "simple";
  };
  services.fprintd.enable = true;

  # Override default so that we use Alt and instead of Super
  systemd.services.xkeysnail.serviceConfig.ExecStart = "${pkgs.xkeysnail}/bin/xkeysnail /etc/xkeysnail/alt.py";
}
