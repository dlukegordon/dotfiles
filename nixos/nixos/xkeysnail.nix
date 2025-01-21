{ config, pkgs, ... }:

{
  environment.etc = {
    xkeysnail = {
      text = ''
        import re
        from xkeysnail.transform import *

        define_keymap(re.compile("librewolf"), {
            K("Super-a"): K("C-a"),
            K("Super-c"): K("C-c"),
            K("Super-f"): K("C-f"),
            K("Super-l"): K("C-l"),
            K("Super-q"): K("C-q"),
            K("Super-t"): K("C-t"),
            K("Super-Shift-t"): K("C-Shift-t"),
            K("Super-v"): K("C-v"),
            K("Super-w"): K("C-w"),
            K("Super-x"): K("C-x"),
        }, "Librewolf")
      '';
    };
  };
  systemd.services.xkeysnail = {
    enable = true;
    wantedBy = [ "display-manager.service" ];
    environment = { DISPLAY = ":0"; };
    serviceConfig = {
      ExecStart = "${pkgs.xkeysnail}/bin/xkeysnail /etc/xkeysnail";
      User = "root";
      Restart = "always";
      RestartSec = "2";
    };
  };
}
