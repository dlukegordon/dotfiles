{
  pkgs,
  pkgsUnstable,
  ...
}:
{
  environment.systemPackages = [
    pkgs.bash-language-server
    pkgs.bc
    pkgs.btop
    pkgs.fastfetch
    pkgs.fd
    pkgs.fzf
    pkgs.git
    pkgs.gnumake
    pkgs.gnupg
    pkgs.hwatch
    pkgs.just
    pkgs.lua-language-server
    pkgs.marksman
    pkgs.mise
    pkgs.mosh
    pkgs.nixd
    pkgs.nixfmt-rfc-style
    pkgs.opensc
    pkgs.ouch
    pkgs.ripgrep
    pkgs.shellcheck
    pkgs.shfmt
    pkgs.stow
    pkgs.stylua
    pkgs.tokei
    pkgs.unzip
    pkgs.wget
    pkgs.yubikey-manager
    pkgs.zoxide
    pkgsUnstable.bat
    pkgsUnstable.carapace
    pkgsUnstable.gh
    pkgsUnstable.ov
  ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    brews = [
      "neovim"
      "nushell"
      "rustup"
      "starship"
      "tmux"
    ];
    casks = [
      "docker-desktop"
      "ghostty"
      "iterm2"
      "meetingbar"
      "nikitabobko/tap/aerospace"
      "raycast"
      "slack"
      "ungoogled-chromium"
      "utm"
      "zed"
      "zen"
      "zoom"
    ];
  };

  nix.enable = false; # For determinate nix
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";
  # security.sudo.extraConfig = "luke ALL=(ALL) NOPASSWD: ALL";
  security.pam.services.sudo_local.touchIdAuth = true;
  system.defaults.NSGlobalDomain.NSAutomaticWindowAnimationsEnabled = false;
  system.defaults.NSGlobalDomain.NSWindowShouldDragOnGesture = true;
  system.defaults.controlcenter.Bluetooth = true;
  system.defaults.controlcenter.Sound = true;
  system.defaults.dock.autohide = true;
  system.defaults.dock.expose-group-apps = true;
  system.defaults.dock.orientation = "right";
  system.defaults.dock.show-recents = false;
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.AppleShowAllFiles = true;
  system.defaults.finder.FXRemoveOldTrashItems = true;
  system.defaults.finder._FXShowPosixPathInTitle = true;
  system.defaults.finder._FXSortFoldersFirst = true;
  system.defaults.spaces.spans-displays = true;
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  system.primaryUser = "luke";
  system.stateVersion = 6;
  users.users.luke.home = "/Users/luke";
}
