{
  config,
  pkgs,
  ...
}:
{
  programs.plasma = {
    enable = true;

    input.keyboard = {
      options = [ "caps:escape" ];
      repeatDelay = 250;
      repeatRate = 30;
    };
    kscreenlocker.appearance.wallpaper = "/home/luke/Pictures/wallpapers/1-gold-rush.png";
    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      wallpaper = "/home/luke/Pictures/wallpapers/1-gold-rush.png";
    };

    configFile = {
      kwinrc.TabBox = {
        ApplicationsMode = 1;
        LayoutName = "big_icons";
      };
      krunnerrc.Plugins."krunner_appstreamEnabled" = false;
    };

    kwin = {
      effects = {
        translucency.enable = true;
        blur.enable = true;
      };
      nightLight = {
        enable = true;
        mode = "times";
        temperature.night = 5750;
        time = {
          morning = "07:00";
          evening = "19:00";
        };
        transitionTime = 30;
      };
    };

    krunner = {
      position = "center";
      shortcuts.launch = "Meta+Alt+Space";
    };

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
              settings.General.highlightNewlyInstalledApps = false;
            };
          }

          "org.kde.plasma.marginsseparator"

          {
            iconTasks = {
              launchers = [
                "applications:zen.desktop"
                "applications:com.mitchellh.ghostty.desktop"
                "applications:slack.desktop"
                "applications:signal.desktop"
                "applications:obsidian.desktop"
                "applications:spotify.desktop"
                "applications:org.kde.dolphin.desktop"
                "applications:systemsettings.desktop"
                "applications:org.keepassxc.KeePassXC.desktop"
                "applications:steam.desktop"
              ];
              behavior = {
                minimizeActiveTaskOnClick = false;
              };
            };
          }

          "org.kde.plasma.marginsseparator"
          {
            systemTray.items = {
              shown = [
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.volume"
              ];
              hidden = [
                "Syncthing Tray"
                "org.kde.kdeconnect"
                "org.kde.plasma.brightness"
                "org.kde.plasma.clipboard"
                "org.kde.plasma.notifications"
              ];
            };
          }
          "org.kde.plasma.digitalclock"
        ];
      }
    ];
  };
}
