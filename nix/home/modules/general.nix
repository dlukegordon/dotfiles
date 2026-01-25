{
  config,
  pkgs,
  pkgsUnstable,
  lib,
  inputs,
  ...
}:
{
  home.username = "luke";
  home.homeDirectory = "/home/luke";

  # Packages that should be installed to the user profile.
  # In general, GUI apps should be added here.
  home.packages = with pkgs; [
    chromium
    google-chrome
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    keepassxc
    libreoffice-qt
    obsidian
    pkgsUnstable.ghostty
    pkgsUnstable.signal-desktop
    pkgsUnstable.slack
    pkgsUnstable.sparrow
    pkgsUnstable.spotify
    pkgsUnstable.tor-browser
    pkgsUnstable.wezterm
    pkgsUnstable.zoom-us
    transmission_4-qt
    vlc
  ];

  # Helix
  programs.helix = {
    enable = true;
    package = pkgsUnstable.helix;
  };

  # Git
  programs.git = {
    enable = true;
    settings = {
      # Email is set in the home configs for each host
      user.name = "Lucas Gordon";
      push = {
        autoSetupRemote = true;
      };
      pull = {
        rebase = true;
      };
    };
  };

  # Jj
  programs.jujutsu = {
    enable = true;
    package = pkgsUnstable.jujutsu;
    ediff = false;
    settings = {
      user = {
        name = "luke";
      };
      ui = {
        default-command = "log";
      };
      "--scope" = [
        {
          "--when" = {
            repositories = [ "~/mysten" ];
          };
          user.email = "luke.gordon@mystenlabs.com";
        }
      ];
      templates = {
        log_node = ''
          coalesce(
            if(!self, label("elided", "~")),
            label(
              separate(" ",
                if(current_working_copy, "working_copy"),
                if(immutable, "immutable"),
                if(conflict, "conflict"),
              ),
              coalesce(
                if(current_working_copy, "@"),
                if(root, "┴"),
                if(immutable, "●"),
                if(conflict, "⊗"),
                "○",
              )
            )
          )
        '';
        op_log_node = ''if(current_operation, "@", "○")'';
      };
    };
  };

  # # Emacs
  # programs.emacs = {
  #   enable = true;
  #   package = pkgs.emacs.override {
  #     withPgtk = true;
  #     withImageMagick = true;
  #   };
  # };

  # Direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Systray
  services.syncthing.tray = {
    enable = true;
    package = pkgsUnstable.syncthingtray;
  };

  # Make some directories
  home.activation.mkDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ${config.home.homeDirectory}/scratch
    mkdir -p ${config.home.homeDirectory}/projects
    mkdir -p ${config.home.homeDirectory}/gits
    mkdir -p ${config.home.homeDirectory}/.local/share/nushell/vendor/autoload
  '';

  fonts.fontconfig.enable = true;

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
