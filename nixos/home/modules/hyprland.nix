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
    hypridle
    hyprlock
    hyprshot
    hyprsunset
    networkmanagerapplet
    pavucontrol
  ];

  programs.waybar = {
    enable = true;
    style = ''
      * {
          /* This is necessary to display all icons correctly */
          font-family: "Noto Sans", "Font Awesome 6 Free";
      }

      window#waybar, tooltip {
          background: alpha(@base00, 1.000000);
          color: white
      }

      #tray {
          padding: 0 5px;
      }

      #power-profiles-daemon {
          padding: 0 5px;
      }

      #workspaces button.focused,
      #workspaces button.active {
          border-bottom: none;
          color: white
      }

      .modules-left #workspaces button {
          border-bottom: none;
          color: @base04
      }

      .modules-left #workspaces button.focused,
      .modules-left #workspaces button.active {
          border-bottom: none;
          color: white
      }

      .modules-center #workspaces button {
          border-bottom: none;
          color: @base04
      }

      .modules-center #workspaces button.focused,
      .modules-center #workspaces button.active {
          border-bottom: none;
          color: white
      }

      .modules-right #workspaces button {
          border-bottom: none;
          color: @base04
      }

      .modules-right #workspaces button.focused,
      .modules-right #workspaces button.active {
          border-bottom: none;
          color: white
      }
    '';
  };
}
