{
  config,
  pkgs,
  pkgsUnstable,
  lib,
  ...
}:
{
  home.stateVersion = "25.05";
  home.username = "luke";
  home.homeDirectory = "/Users/luke";
  programs.home-manager.enable = true;

  # Git
  programs.git = {
    enable = true;
    userName = "Luke Gordon";
    userEmail = "luke.gordon@mystenlabs.com";
    extraConfig = {
      push = {
        autoSetupRemote = true;
      };
      pull = {
        rebase = true;
      };
    };
  };

  # Jj
  programs.jujutsu = {
    enable = true;
    package = pkgsUnstable.jujutsu;
    ediff = false;
    settings = {
      user = {
        name = "Luke Gordon";
        email = "luke.gordon@mystenlabs.com";
      };
      ui = {
        default-command = "log";
      };
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
