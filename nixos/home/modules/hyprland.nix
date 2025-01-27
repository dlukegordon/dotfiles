{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.fuzzel.enable = true;
  services.hyprpaper.enable = true;
  services.swaync.enable = true;
  home.packages = with pkgs; [
    hyprshot
  ];

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        height = 40;
        spacing = 4;
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "mpd"
          "idle_inhibitor"
          "pulseaudio"
          "network"
          "power-profiles-daemon"
          "cpu"
          "memory"
          "temperature"
          "backlight"
          "keyboard-state"
          "sway/language"
          "battery"
          "battery#bat2"
          "clock"
          "tray"
          "custom/power"
        ];
      };
    };
  };
}
