{
  config,
  pkgs,
  pkgsUnstable,
  inputs,
  ...
}:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    inputs.opencode.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.bash-language-server
    pkgs.bc
    pkgs.btop
    pkgs.ccid
    pkgs.cmake
    pkgs.fastfetch
    pkgs.fd
    pkgs.fzf
    pkgs.gcc
    pkgs.gh
    pkgs.git
    pkgs.gnumake
    pkgs.gnupg
    pkgs.hwatch
    pkgs.inetutils
    pkgs.just
    pkgs.kdePackages.discover
    pkgs.kdePackages.isoimagewriter
    pkgs.kdePackages.kcharselect
    pkgs.kdePackages.kclock
    pkgs.kdePackages.kcolorchooser
    pkgs.kdePackages.kolourpaint
    pkgs.kdePackages.ksystemlog
    pkgs.kdePackages.partitionmanager
    pkgs.kdePackages.plasma-browser-integration
    pkgs.kdePackages.plasma-workspace-wallpapers
    pkgs.kdePackages.sddm-kcm
    pkgs.lazyjournal
    pkgs.less
    pkgs.libtool
    pkgs.lsd
    pkgs.lsof
    pkgs.lua-language-server
    pkgs.marksman
    pkgs.mosh
    pkgs.nixd
    pkgs.nixfmt-rfc-style
    pkgs.opensc
    pkgs.ouch
    pkgs.pop-hp-wallpapers
    pkgs.pop-wallpapers
    pkgs.psmisc
    pkgs.rage
    pkgs.ripgrep
    pkgs.shellcheck
    pkgs.shfmt
    pkgs.starship
    pkgs.stow
    pkgs.stylua
    pkgs.tmux
    pkgs.tokei
    pkgs.tree-sitter
    pkgs.unzip
    pkgs.usbutils
    pkgs.uutils-coreutils
    pkgs.wayland-utils
    pkgs.wget
    pkgs.wireguard-tools
    pkgs.wl-clipboard-rs
    pkgs.yazi
    pkgs.yubikey-manager
    pkgs.zoxide
    pkgsUnstable.bat
    pkgsUnstable.bitcoind
    pkgsUnstable.buf
    pkgsUnstable.carapace
    pkgsUnstable.cargo-binstall
    pkgsUnstable.cargo-nextest
    pkgsUnstable.claude-code
    pkgsUnstable.neovim
    pkgsUnstable.nodejs
    pkgsUnstable.nushell
    pkgsUnstable.ov
    pkgsUnstable.python3
    pkgsUnstable.rustup
  ];

  # Shells
  environment.shells = [
    pkgs.bash
    pkgs.zsh
    pkgsUnstable.nushell
  ];

  # Link nushell to /usr/local/bin to make a single path for nixos and darwin
  system.activationScripts.bin-nu.text = ''
    mkdir -p /usr/local/bin
    ln -sfn ${pkgsUnstable.nushell}/bin/nu /usr/local/bin/nu
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
  environment.etc."gnupg/scdaemon.conf".text = ''
    disable-ccid
  '';

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
    package = pkgsUnstable.steam;
    gamescopeSession.enable = true;
    protontricks.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  hardware.steam-hardware.enable = true;
  services.udev.packages = [ pkgs.game-devices-udev-rules ];
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  programs.gamemode.enable = true;
  # Allow SteamVR to run properly
  system.activationScripts.steamvr-capset.text = ''
    ${pkgs.libcap}/bin/setcap CAP_SYS_NICE+ep /home/luke/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/vrcompositor-launcher 2>/dev/null || true
  '';

  # Tailscale
  services.tailscale = {
    enable = true;
    package = pkgsUnstable.tailscale;
    useRoutingFeatures = "client";
  };

  # Zoom
  programs.zoom-us = {
    enable = true;
    package = pkgsUnstable.zoom-us;
  };

  # Other programs/services
  programs.appimage.enable = true;
  programs.nix-ld.enable = true;

  # Force some crappy Electron apps to use Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Fonts
  fonts.packages = [
    (pkgs.callPackage ./etbembo.nix { })
    pkgs._0xproto
    pkgs.caladea
    pkgs.cascadia-code
    pkgs.comic-mono
    pkgs.commit-mono
    pkgs.cozette
    pkgs.dejavu_fonts
    pkgs.fantasque-sans-mono
    pkgs.fira-code
    pkgs.font-awesome
    pkgs.garamond-libre
    pkgs.gelasio
    pkgs.iosevka
    pkgs.iosevka-comfy.comfy
    pkgs.jetbrains-mono
    pkgs.libre-baskerville
    pkgs.nerd-fonts.symbols-only
    pkgs.noto-fonts
    pkgs.noto-fonts-color-emoji
    pkgs.roboto-mono
    pkgsUnstable.lilex
    pkgsUnstable.nerd-fonts.comic-shanns-mono
  ];
}
