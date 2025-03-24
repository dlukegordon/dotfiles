{
  config,
  pkgs,
  ...
}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alejandra
    asdf-vm
    bash-language-server
    bc
    btop
    ccid
    cmake
    dockfmt
    fd
    fzf
    gcc
    git
    google-chrome
    golangci-lint
    gomodifytags
    gopls
    gore
    gotests
    jq
    libsForQt5.kdbusaddons
    gnumake
    gnupg
    inetutils
    ivpn
    ivpn-service
    less
    libtool
    lsd
    lsof
    neovim
    nushell
    fastfetch
    font-manager
    nixfmt-classic
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
    uv
    unzip
    wget
    wireguard-tools
    wl-clipboard-rs
    # xclip
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
