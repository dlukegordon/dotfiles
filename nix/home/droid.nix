{
  config,
  pkgs,
  pkgsUnstable,
  lib,
  ...
}:
{
  home.stateVersion = "24.05";

  home.packages = [ ];

  # Create directories needed by nushell
  home.activation.mkDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ${config.home.homeDirectory}/.local/share/nushell/vendor/autoload
  '';

  # Git
  programs.git = {
    enable = true;
    settings = {
      user.name = "Lucas Gordon";
      user.email = "luke@zfold7";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };

  # Jj
  programs.jujutsu = {
    enable = true;
    package = pkgsUnstable.jujutsu;
    ediff = false;
    settings = {
      user = {
        name = "luke";
        email = "luke@zfold7";
      };
      ui = {
        default-command = "log";
        color = "always";
      };
      "--scope" = [
        {
          "--when" = {
            repositories = [ "~/mysten" ];
          };
          user.email = "luke.gordon@mystenlabs.com";
        }
      ];
      templates = {
        log_node = ''
          coalesce(
            if(!self, label("elided", "~")),
            label(
              separate(" ",
                if(current_working_copy, "working_copy"),
                if(immutable, "immutable"),
                if(conflict, "conflict"),
              ),
              coalesce(
                if(current_working_copy, "@"),
                if(root, "┴"),
                if(immutable, "●"),
                if(conflict, "⊗"),
                "○",
              )
            )
          )
        '';
        op_log_node = ''if(current_operation, "@", "○")'';
      };
    };
  };
}
