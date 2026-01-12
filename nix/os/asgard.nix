{
  config,
  pkgs,
  pkgsUnstable,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/pkgs.nix
    ./modules/system.nix
  ];

  networking.hostName = "asgard";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Fingerprint reader
  # For some reason this seems to cause a problem with kdewallet sometimes. If you keep getting
  # annoying popups asking for access to kdewallet, you can solve this by deleting the wallet:
  # rm -rf ~/.local/share/kwalletd/
  # systemd.services.fprintd = {
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig.Type = "simple";
  # };
  # services.fprintd.enable = true;

  # Enable Intel Quick Sync Video
  hardware.graphics.extraPackages = [ pkgs.vpl-gpu-rt ];
}
