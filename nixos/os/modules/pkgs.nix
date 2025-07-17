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
    carapace
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
    inetutils
    ivpn
    ivpn-service
    just
    less
    libreoffice-qt
    libsForQt5.kdbusaddons
    libtool
    lsd
    lsof
    lua-language-server
    mosh
    nixd
    nixfmt-rfc-style
    opensc
    pkgsUnstable.bat
    pkgsUnstable.cargo
    pkgsUnstable.clippy
    pkgsUnstable.jjui
    pkgsUnstable.lazyjj
    pkgsUnstable.neovim
    pkgsUnstable.nushell
    pkgsUnstable.ov
    pkgsUnstable.rust-analyzer
    pkgsUnstable.rustc
    pkgsUnstable.rustfmt
    psmisc
    rage
    ripgrep
    shellcheck
    shfmt
    starship
    stow
    tmux
    unzip
    usbutils
    uutils-coreutils
    wget
    wireguard-tools
    wl-clipboard-rs
    xfce.ristretto
    xfce.thunar
    xorg.xhost
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
  services.tumbler.enable = true;

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
    pkgsUnstable.lilex
    pkgsUnstable.nerd-fonts.comic-shanns-mono
    roboto-mono
  ];
}
