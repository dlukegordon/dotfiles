{
  pkgs,
  pkgsUnstable,
  ...
}:
{
  environment.packages = [
    pkgs.fastfetch
    pkgs.git
    pkgs.gnumake
    pkgs.inetutils
    pkgs.less
    pkgs.neovim
    pkgs.nushell
    pkgs.ouch
    pkgs.stow
    pkgs.tmux
    pkgs.unzip
    pkgs.usbutils
    pkgsUnstable.bat
    pkgsUnstable.carapace
    pkgsUnstable.fd
    pkgsUnstable.fzf
    pkgsUnstable.mosh
    pkgsUnstable.openssh
    pkgsUnstable.ov
    pkgsUnstable.ripgrep
    pkgsUnstable.starship
    pkgsUnstable.zoxide
  ];

  terminal.font = "${pkgs.nerd-fonts.jetbrains-mono}/share/fonts/truetype/NerdFonts/JetBrainsMono/JetBrainsMonoNerdFont-Regular.ttf";

  # Dimidium color scheme
  # From: https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Dimidium.itermcolors
  terminal.colors = {
    background = "#141414";
    foreground = "#BAB7B6";
    cursor = "#37E57B";
    color0 = "#000000"; # black
    color1 = "#CF494C"; # red
    color2 = "#60B442"; # green
    color3 = "#DB9C11"; # yellow
    color4 = "#0575D8"; # blue
    color5 = "#AF5ED2"; # magenta
    color6 = "#1DB6BB"; # cyan
    color7 = "#BAB7B6"; # white
    color8 = "#817E7E"; # bright black
    color9 = "#FF643B"; # bright red
    color10 = "#37E57B"; # bright green
    color11 = "#FCCD1A"; # bright yellow
    color12 = "#688DFD"; # bright blue
    color13 = "#ED6FE9"; # bright magenta
    color14 = "#32E0FB"; # bright cyan
    color15 = "#DEE3E4"; # bright white
  };

  user.shell = "${pkgs.nushell}/bin/nu";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = "24.05";
}
