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
    stow
    tinymist
    tmux
    typst
    uv
    unzip
    wget
    wireguard-tools
    xclip
    xkeysnail
    xorg.xhost
    yubikey-manager
    zoxide
  ];

  # Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };
  users.defaultUserShell = pkgs.zsh;

  # IVPN
  services.ivpn.enable = true;

  # Yubikeys
  services.pcscd.enable = true;

  # Bluetooth
  services.blueman.enable = true;

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
