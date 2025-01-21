{ config, pkgs, ... }:

let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in {
  programs = {
    librewolf = {
      enable = true;
      languagePacks = [ "en-US" ];

      # ---- Profiles ----
      profiles.default = {
        name = "default";
        id = 0;
        isDefault = true;

        userChrome = ''
          #TabsToolbar {
             visibility: collapse;
          }

          #tracking-protection-icon-container {
            display: none;
          }

          #sidebar-header {
            display: none;
          }
        '';
      };

      # ---- POLICIES ----
      # Check about:policies#documentation for options.
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        DisableFirefoxScreenshots = true;
        DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
        SanitizeOnShutdown = false;

        # ---- PREFERENCES ----
        # Check about:config for options.
        Preferences = {
          "browser.contentblocking.category" = {
            Value = "standard";
            Status = "locked";
          };
          "browser.newtabpage.enabled" = lock-false;
          "browser.search.suggest.enabled" = lock-false;
          "browser.search.suggest.enabled.private" = lock-false;
          "browser.startup.homepage" = {
            Value = "chrome://browser/content/blanktab.html";
            Status = "locked";
          };
          "browser.startup.page" = {
            Value = 3;
            Status = "locked";
          };
          "browser.urlbar.shortcuts.actions" = lock-false;
          "browser.urlbar.shortcuts.bookmarks" = lock-false;
          "browser.urlbar.shortcuts.history" = lock-false;
          "browser.urlbar.shortcuts.tabs" = lock-false;
          "privacy.sanitize.sanitizeOnShutdown" = lock-false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = lock-true;
        };

        # ---- EXTENSIONS ----
        # Check about:support for extension/add-on ID strings.
        # Valid strings for installation_mode are "allowed", "blocked",
        # "force_installed" and "normal_installed".
        ExtensionSettings = {
          # uBlock Origin
          "uBlock0@raymondhill.net" = {
            install_url =
              "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
            default_area = "navbar";
          };

          # Bitwarden
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url =
              "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
            default_area = "navbar";
          };

          # Vimium
          "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
            install_url =
              "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
            installation_mode = "force_installed";
            default_area = "navbar";
          };

          # Tree Style Tabs
          "treestyletab@piro.sakura.ne.jp" = {
            install_url =
              "https://addons.mozilla.org/firefox/downloads/latest/tree-style-tab/latest.xpi";
            installation_mode = "force_installed";
            default_area = "menupanel";
          };
          "tst-indent-line@piro.sakura.ne.jp" = {
            install_url =
              "https://addons.mozilla.org/firefox/downloads/latest/tst-indent-line/latest.xpi";
            installation_mode = "force_installed";
            default_area = "menupanel";
          };
          "tst-more-tree-commands@piro.sakura.ne.jp" = {
            install_url =
              "https://addons.mozilla.org/firefox/downloads/latest/tst-more-tree-commands/latest.xpi";
            installation_mode = "force_installed";
            default_area = "menupanel";
          };

          # Theme
          "arc-dark-theme@afnankhan" = {
            install_url =
              "https://addons.mozilla.org/firefox/downloads/latest/arc-dark-theme-we/latest.xpi";
            installation_mode = "force_installed";
          };
        };
      };
    };
  };
}
