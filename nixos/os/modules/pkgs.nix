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
    ccid
    cmake
    dockfmt
    fastfetch
    fd
    font-manager
    fzf
    gcc
    git
    gnumake
    gnupg
    golangci-lint
    gomodifytags
    google-chrome
    gopls
    gore
    gotests
    inetutils
    ivpn
    ivpn-service
    jq
    less
    libsForQt5.kdbusaddons
    libtool
    lsd
    lsof
    mosh
    nixfmt-classic
    nushell
    nvimpager
    opensc
    pandoc
    pkgsUnstable.dioxus-cli
    pkgsUnstable.jujutsu
    pkgsUnstable.lazyjj
    pkgsUnstable.neovim
    pkgsUnstable.wasm-bindgen-cli
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
  users.defaultUserShell = pkgs.zsh;

  # GPG and Yubikeys
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Flatpak (yes it sucks but need for zen browser)
  services.flatpak.enable = true;

  # Other programs/services
  programs.nix-ld.enable = true;
  programs.steam.enable = true;
  services.blueman.enable = true;
  services.ivpn.enable = true;
  services.tumbler.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    font-awesome
    roboto-mono
    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    (callPackage ./etbembo.nix {})
    dejavu_fonts
    noto-fonts
    garamond-libre
    gelasio
    caladea
    libre-baskerville
  ];
}
