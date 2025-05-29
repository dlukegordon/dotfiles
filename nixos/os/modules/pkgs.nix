{
  config,
  pkgs,
  pkgsUnstable,
  ...
}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alejandra
    appimage-run
    asdf-vm
    bash-language-server
    bc
    btop
    carapace
    ccid
    cmake
    difftastic
    dockfmt
    fastfetch
    fd
    font-manager
    fzf
    gcc
    gh
    git
    gnumake
    gnupg
    golangci-lint
    gomodifytags
    google-chrome
    gopls
    gore
    gotests
    hwatch
    inetutils
    ivpn
    ivpn-service
    just
    less
    libsForQt5.kdbusaddons
    libtool
    lsd
    lsof
    mosh
    nixfmt-classic
    nushell
    opensc
    pandoc
    pkgsUnstable.bat
    pkgsUnstable.jjui
    pkgsUnstable.jujutsu
    pkgsUnstable.lazyjj
    pkgsUnstable.neovim
    pkgsUnstable.ov
    psmisc
    rage
    re2
    ripgrep
    rust-analyzer
    rustup
    shellcheck
    shfmt
    starship
    stow
    tinymist
    tmux
    tree-sitter
    trunk
    typst
    unzip
    usbutils
    uutils-coreutils
    uv
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
    nushell
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
    (callPackage ./etbembo.nix {})
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
