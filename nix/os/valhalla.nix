{
  config,
  pkgs,
  pkgsUnstable,
  ...
}:
let
  red-rgb = pkgs.writeScriptBin "red-rgb" ''
    #!/bin/sh
    NUM_DEVICES=$(${pkgs.openrgb}/bin/openrgb --noautoconnect --list-devices | grep -E '^[0-9]+: ' | wc -l)

    for i in $(seq 0 $(($NUM_DEVICES - 1))); do
      ${pkgs.openrgb}/bin/openrgb --noautoconnect --device $i --mode static --color FF0000
    done
    ${pkgs.openrgb}/bin/openrgb --device "Z790 AORUS ELITE AX" --mode static --color FF0000
  '';
in
{
  imports = [
    ./hardware-configuration.nix
    ./modules/nvidia.nix
    ./modules/pkgs.nix
    ./modules/system.nix
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
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
  };
  systemd.services.rgb = {
    description = "rgb";
    serviceConfig = {
      ExecStart = "${red-rgb}/bin/red-rgb";
      Type = "oneshot";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
