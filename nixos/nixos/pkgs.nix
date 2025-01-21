{ config, pkgs, ... }:

{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
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
    less
    libtool
    lsd
    lsof
    neovim
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
    wezterm
    wireguard-tools
    xclip
    xkeysnail
    xorg.xhost
    zoxide
  ];

  nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1w" ];

  # Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };
  users.defaultUserShell = pkgs.zsh;

  fonts.packages = with pkgs; [
    font-awesome
    roboto-mono
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    (callPackage ./etbembo.nix { })
  ];

  programs.nix-ld.enable = true;
}
