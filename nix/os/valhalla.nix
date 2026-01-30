{
  config,
  pkgs,
  pkgsUnstable,
  ...
}:
let
  red-rgb = pkgs.writeScriptBin "red-rgb" ''
    #!/bin/sh
    ${pkgs.openrgb}/bin/openrgb --mode static --color FF0000
  '';
in
{
  imports = [
    ./hardware-configuration.nix
    ./modules/system.nix
    ./modules/nvidia.nix
    ./modules/pkgs.nix
    ./modules/xremap.nix
    ./modules/syncthing.nix
    ./modules/ai.nix
  ];

  networking.hostName = "valhalla";
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  time.timeZone = "America/Chicago";

  # Sunshine game streaming server
  services.sunshine = {
    enable = true;
    package = pkgsUnstable.sunshine.override { cudaSupport = true; };
    autoStart = false;
    capSysAdmin = true;
    openFirewall = true;
  };

  # Control RGB
  # services.hardware.openrgb = {
  #   enable = true;
  #   package = pkgs.openrgb-with-all-plugins;
  # };
  # boot.kernelModules = [
  #   "i2c-dev"
  #   "i2c-i801"
  # ];
  # systemd.services.rgb = {
  #   description = "rgb";
  #   after = [
  #     "openrgb.service"
  #     "suspend.target"
  #   ];
  #   requires = [ "openrgb.service" ];
  #   serviceConfig = {
  #     ExecStart = "${red-rgb}/bin/red-rgb";
  #     Type = "oneshot";
  #   };
  #   wantedBy = [
  #     "multi-user.target"
  #     "suspend.target"
  #   ];
  # };
}
