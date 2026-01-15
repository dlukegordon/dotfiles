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
                "applications:steam.desktop"
              ];
              behavior = {
                minimizeActiveTaskOnClick = false;
              };
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
        # Free up Meta+0
        "view_actual_size" = [ ];
        # Free up Meta+W
        "Overview" = [ "Meta+0" ];
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
