{
  config,
  pkgs,
  ...
}: {
  programs.plasma = {
    enable = true;
    workspace.lookAndFeel = "org.kde.breezedark.desktop";
    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    configFile.kded5rc = {
      # So that plasma doesn't keep creating ~/.gtkrc-2.0 which we then have to delete for stylix
      "Module-gtkconfig"."autoload" = false;
    };

    panels = [
      {
        location = "bottom";
        height = 40;
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
                "applications:librewolf.desktop"
                "applications:org.wezfurlong.wezterm.desktop"
                "applications:emacsclient.desktop"
              ];
            };
          }

          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];

    input.keyboard.options = ["caps:escape"];

    shortcuts = {
      ksmserver = {
        # Free up Meta+L
        "Lock Session" = ["Screensaver"];
      };
      kwin = {
        # Free up Meta+T
        "Edit Tiles" = [];
        # Free up Meta+W
        "Overview" = [];
        # "Walk Through Windows" = [ "Alt+Tab" "Meta+Tab" ];
        # "Walk Through Windows (Reverse)" = [ "Alt+Shift+Tab" "Meta+Shift+Tab" ];
        # "Walk Through Windows of Current Application" = [ "Alt+`" "Meta+`" ];
        # "Walk Through Windows of Current Application (Reverse)" =
        #   [ "Alt+~" "Meta+~" ];
      };
      plasmashell = {
        # Free up Meta+S
        "stop current activity" = [];
        # Free up Meta+V
        "show-on-mouse-pos" = [];
        # Free up Meta+A
        "next activity" = [];
        # Free up Meta+Shift+A
        "previous activity" = [];
        # Free up Meta+Q
        "manage activities" = [];

        "activate application launcher" = ["Meta+Space"];
        "activate task manager entry 1" = ["Meta+1" "Meta+Ctrl+Alt+Shift+B"];
        "activate task manager entry 2" = ["Meta+2" "Meta+Ctrl+Alt+Shift+T"];
        "activate task manager entry 3" = ["Meta+3" "Meta+Ctrl+Alt+Shift+E"];
        "activate task manager entry 4" = ["Meta+4" "Meta+Ctrl+Alt+Shift+S"];
      };
    };
  };
}
