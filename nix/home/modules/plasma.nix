{
  config,
  pkgs,
  ...
}:
{
  programs.plasma = {
    enable = true;
    workspace.lookAndFeel = "org.kde.breezedark.desktop";
    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    workspace.wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/DarkestHour/contents/images/2560x1600.jpg";
    panels = [
      {
        location = "bottom";
        height = 42;
        floating = false;

        widgets = [
          {
            kickoff = {
              icon = "nix-snowflake-white";
              favoritesDisplayMode = "list";
            };
          }

          "org.kde.plasma.marginsseparator"

          {
            iconTasks = {
              launchers = [
                "applications:app.zen_browser.zen.desktop"
                "applications:com.mitchellh.ghostty.desktop"
                "applications:slack.desktop"
                "applications:signal.desktop"
                "applications:spotify.desktop"
                "applications:org.kde.dolphin.desktop"
                "applications:systemsettings.desktop"
              ];
            };
          }

          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];

    input.keyboard.options = [ "caps:escape" ];

    shortcuts = {
      kwin = {
        # Free up Meta+W
        "Overview" = [ ];
        "Window Close" = [ "Meta+W" ];
        "Window Fullscreen" = [ "Meta+Z" ];
      };
      plasmashell = {
        # Free up Meta+V
        "show-on-mouse-pos" = [ ];
        "activate application launcher" = [ "Meta+Space" ];
      };
    };
  };
}
