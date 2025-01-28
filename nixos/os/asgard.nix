{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/pkgs.nix
    ./modules/stylix.nix
    ./modules/system.nix
    ./modules/xkeysnail.nix
  ];

  networking.hostName = "asgard";

  # Fingerprint reader
  # For some reason this seems to cause a problem with kdewallet sometimes. If you keep getting
  # annoying popups asking for access to kdewallet, you can solve this by deleting the wallet:
  # rm -rf ~/.local/share/kwalletd/
  systemd.services.fprintd = {
    wantedBy = ["multi-user.target"];
    serviceConfig.Type = "simple";
  };
  services.fprintd.enable = true;

  # Override default so that we use Alt and instead of Super
  # systemd.services.xkeysnail.serviceConfig.ExecStart = "${pkgs.xkeysnail}/bin/xkeysnail /etc/xkeysnail/alt.py";

  # Enable Intel Quick Sync Video
  hardware.graphics.extraPackages = [pkgs.vpl-gpu-rt];
}
