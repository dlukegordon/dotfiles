{
  config,
  pkgs,
  pkgsUnstable,
  ...
}:
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
}
