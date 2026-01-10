{
  config,
  pkgs,
  pkgsUnstable,
  ...
}:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bash-language-server
    bc
    btop
    ccid
    chromium
    cmake
    fastfetch
    fd
    font-manager
    fzf
    gcc
    gh
    git
    gnumake
    gnupg
    google-chrome
    hunspell
    hunspellDicts.en_US
    hwatch
    imagemagick
    inetutils
    just
    kdePackages.discover
    kdePackages.isoimagewriter
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.kclock
    kdePackages.kcolorchooser
    kdePackages.kolourpaint
    kdePackages.ksystemlog
    kdePackages.partitionmanager
    kdePackages.plasma-browser-integration
    kdePackages.sddm-kcm
    lazyjournal
    less
    libreoffice-qt
    libtool
    lsd
    lsof
    lua-language-server
    marksman
    mosh
    nautilus
    nixd
    nixfmt-rfc-style
    opensc
    ouch
    pkgsUnstable.bat
    pkgsUnstable.carapace
    pkgsUnstable.claude-code
    pkgsUnstable.gitu
    pkgsUnstable.jjui
    pkgsUnstable.lazyjj
    pkgsUnstable.neovim
    pkgsUnstable.nodejs
    pkgsUnstable.nushell
    pkgsUnstable.opencode
    pkgsUnstable.ov
    pkgsUnstable.python3
    pkgsUnstable.rustup
    pkgsUnstable.slack
    pkgsUnstable.spotify
    psmisc
    rage
    ripgrep
    shellcheck
    shfmt
    starship
    stow
    stylua
    tmux
    tokei
    unzip
    usbutils
    uutils-coreutils
    wayland-utils
    wget
    wireguard-tools
    wl-clipboard-rs
    yazi
    yubikey-manager
    zoxide
  ];

  # Shells
  environment.shells = with pkgs; [
    bash
    zsh
    pkgsUnstable.nushell
  ];

  # Link nushell to /usr/local/bin to make a single path for nixos and darwin
  system.activationScripts.bin-nu.text = ''
    mkdir -p /usr/local/bin
    ln -sfn ${pkgs.nushell}/bin/nu /usr/local/bin/nu
  '';

  # Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };

  # GPG and Yubikeys
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Flatpak
  services.flatpak.enable = true;
  services.flatpak.package = pkgsUnstable.flatpak;
  system.activationScripts.flatpak-repo = {
    text = ''
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # Steam / games
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    protontricks.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  programs.gamemode.enable = true;

  # Other programs/services
  programs.nix-ld.enable = true;
  programs.appimage.enable = true;
  services.tailscale = {
    enable = true;
    package = pkgsUnstable.tailscale;
    useRoutingFeatures = "client";
  };

  # Fonts
  fonts.packages = with pkgs; [
    (callPackage ./etbembo.nix { })
    _0xproto
    caladea
    cascadia-code
    comic-mono
    commit-mono
    cozette
    dejavu_fonts
    fantasque-sans-mono
    fira-code
    font-awesome
    garamond-libre
    gelasio
    iosevka
    iosevka-comfy.comfy
    jetbrains-mono
    libre-baskerville
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-color-emoji
    pkgsUnstable.lilex
    pkgsUnstable.nerd-fonts.comic-shanns-mono
    roboto-mono
  ];
}
