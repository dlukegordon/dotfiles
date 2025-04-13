{
  config,
  pkgs,
  ...
}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # xclip
    alejandra
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
    neovim
    nixfmt-classic
    nushell
    nvimpager
    opensc
    pandoc
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
    typst
    unzip
    uv
    wget
    wireguard-tools
    wl-clipboard-rs
    xkeysnail
    xorg.xhost
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

  # IVPN
  services.ivpn.enable = true;

  # GPG and Yubikeys
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Bluetooth
  services.blueman.enable = true;

  # Steam
  programs.steam.enable = true;

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

  programs.nix-ld.enable = true;
}
