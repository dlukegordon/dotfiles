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
    ivpn
    ivpn-service
    less
    libtool
    lsd
    lsof
    neovim
    neofetch
    nixd
    nixfmt-classic
    nvimpager
    opensc
    pandoc
    re2
    ripgrep
    rust-analyzer
    rustup
    shellcheck
    shfmt
    stow
    tmux
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

  # Fonts
  fonts.packages = with pkgs; [
    font-awesome
    roboto-mono
    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    (callPackage ./etbembo.nix {})
  ];

  programs.nix-ld.enable = true;
}
