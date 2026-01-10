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

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Sunshine game streaming server
  services.sunshine = {
    enable = true;
    package = pkgsUnstable.sunshine.override { cudaSupport = true; };
    autoStart = false;
    capSysAdmin = true;
    openFirewall = true;
  };
}
