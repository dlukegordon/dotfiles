{
  config,
  pkgs,
  lib,
  ...
}: {
  home.activation = {
    installDoom = let
      emacs-dir = "${config.home.homeDirectory}/.config/emacs";
    in
      lib.hm.dag.entryAfter ["writeBoundary"] ''
        if [ ! -d "${emacs-dir}" ]; then
          ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs ${emacs-dir}
        fi
      '';
  };
}
