{
  config,
  pkgs,
  pkgsUnstable,
  lib,
  ...
}: {
  imports = [];

  home.stateVersion = "24.11";

  programs.git.userEmail = "nidavellir";
  programs.jujutsu.settings.user.email = "luke@nidavellir";

  # Git
  programs.git = {
    enable = true;
    userName = "Lucas Gordon";
    # Email is set in the home configs for each host
    extraConfig = {
      push = {autoSetupRemote = true;};
      pull = {rebase = true;};
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
      };
      ui = {
        default-command = "log";
        diff.tool = ["difft" "--display=side-by-side-show-both" "--color=always" "$left" "$right"];
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
