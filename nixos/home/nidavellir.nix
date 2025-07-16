{
  config,
  pkgs,
  pkgsUnstable,
  lib,
  ...
}:
{
  imports = [ ];

  home.stateVersion = "24.11";

  programs.git.userEmail = "nidavellir";

  # Git
  programs.git = {
    enable = true;
    userName = "Lucas Gordon";
    # Email is set in the home configs for each host
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
        name = "luke";
        email = "luke@nidavellir";
      };
      ui = {
        default-command = "log";
      };
      templates = {
        log_node = ''
          coalesce(
            if(!self, "🮀"),
            if(current_working_copy, "@"),
            if(root, "┴"),
            if(immutable, "●", "○"),
          )
        '';
        op_log_node = ''if(current_operation, "@", "○")'';
      };
    };
  };
}
