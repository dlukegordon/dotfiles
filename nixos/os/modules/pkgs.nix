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
    appimage-run
    bash-language-server
    bc
    btop
    ccid
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
    ivpn
    ivpn-service
    just
    kdePackages.kdbusaddons
    lazyjournal
    less
    libqalculate
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
    pkgsUnstable.nushell
    pkgsUnstable.ov
    pkgsUnstable.rustup
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
    wget
    wireguard-tools
    wl-clipboard-rs
    xorg.xhost
    xwayland-satellite
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

  # Flatpak (yes it sucks but need for zen browser)
  services.flatpak.enable = true;
  services.flatpak.package = pkgsUnstable.flatpak;

  # Other programs/services
  programs.nix-ld.enable = true;
  programs.steam.enable = true;
  services.blueman.enable = true;
  services.ivpn.enable = true;

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
