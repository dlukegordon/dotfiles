{
  config,
  pkgs,
  lib,
  ...
}: {
  home.username = "luke";
  home.homeDirectory = "/home/luke";

  # Packages that should be installed to the user profile.
  # In general, GUI apps should be added here.
  home.packages = with pkgs; [
    keepassxc
    obsidian
    signal-desktop
    sparrow
    transmission_4-qt
    vlc
    wezterm
  ];

  # Stylix (most of the configs are in os but we have some here in home)
  stylix = {
    autoEnable = true;

    fonts = {
      sizes.applications = 10;
      sizes.popups = 16;
      sizes.desktop = 7;

      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };

      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
    };
  };

  # Git
  programs.git = {
    enable = true;
    userName = "Lucas Gordon";
    # Email is set in the home configs for each host
    extraConfig = {
      push = {autoSetupRemote = true;};
      pull = {rebase = true;};
    };
  };

  # Emacs
  programs.emacs = {
    enable = true;
    # package = pkgs.emacs29-pgtk;
  };
  services.emacs = {
    enable = true;
    startWithUserSession = "graphical";
    # package = pkgs.emacs29-pgtk;
  };

  # Thunderbird
  programs.thunderbird = {
    enable = true;
    profiles.default = {
      isDefault = true;
      settings = {
        # If we don't do this, the browser ui is strangely large
        "browser.display.os-zoom-behavior" = 0;
      };
    };
  };

  # Allow xkeysnail to access the X display
  # systemd.user.services.xhostaccess = {
  #   Install.WantedBy = ["graphical-session.target"];
  #   Service.ExecStart = "${pkgs.xorg.xhost}/bin/xhost +SI:localuser:root";
  # };

  # Make some directories
  home.activation.mkDirs = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ${config.home.homeDirectory}/scratch
    mkdir -p ${config.home.homeDirectory}/projects
    mkdir -p ${config.home.homeDirectory}/gits
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
