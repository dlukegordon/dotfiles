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
    inputs.ghostty.packages.${pkgs.system}.default
    keepassxc
    obsidian
    pkgsUnstable.signal-desktop
    pkgsUnstable.wezterm
    sparrow
    transmission_4-qt
    vlc
  ];

  # Btop. We also add to os pkgs, but we also add here so Stylix will theme.
  programs.btop.enable = true;

  # Helix
  programs.helix.enable = true;
  programs.helix.package = pkgsUnstable.helix;

  # Git
  programs.git = {
    enable = true;
    userName = "Lucas Gordon";
    # Email is set in the home configs for each host
    extraConfig = {
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

  # Emacs
  programs.emacs = {
    enable = true;
  };

  # Thunderbird
  programs.thunderbird = {
    enable = true;
    profiles.default = {
      isDefault = true;
      settings = {
        # If we don't do this, the browser ui is strangely large
        "browser.display.os-zoom-behavior" = 1;
      };
    };
  };

  # Direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
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

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "org.kde.okular.desktop";
      "application/x-bzpdf" = "org.kde.okular.desktop";
      "application/x-gzpdf" = "org.kde.okular.desktop";
      "application/x-pdf" = "org.kde.okular.desktop";
      "image/bmp" = "org.xfce.ristretto.desktop";
      "image/gif" = "org.xfce.ristretto.desktop";
      "image/heic" = "org.xfce.ristretto.desktop";
      "image/heif" = "org.xfce.ristretto.desktop";
      "image/jpeg" = "org.xfce.ristretto.desktop";
      "image/png" = "org.xfce.ristretto.desktop";
      "image/svg+xml" = "org.xfce.ristretto.desktop";
      "image/tiff" = "org.xfce.ristretto.desktop";
      "image/vnd.microsoft.icon" = "org.xfce.ristretto.desktop";
      "image/webp" = "org.xfce.ristretto.desktop";
      "image/x-icon" = "org.xfce.ristretto.desktop";
      "image/x-pcx" = "org.xfce.ristretto.desktop";
      "image/x-portable-bitmap" = "org.xfce.ristretto.desktop";
      "image/x-portable-graymap" = "org.xfce.ristretto.desktop";
      "image/x-portable-pixmap" = "org.xfce.ristretto.desktop";
      "image/x-tga" = "org.xfce.ristretto.desktop";
      "image/x-xbitmap" = "org.xfce.ristretto.desktop";
      "image/x-xcf" = "org.xfce.ristretto.desktop";
      "image/x-xpixmap" = "org.xfce.ristretto.desktop";
    };
  };
}
