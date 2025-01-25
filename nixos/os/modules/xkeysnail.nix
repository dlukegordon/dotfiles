{
  config,
  lib,
  pkgs,
  ...
}: {
  # TODO: implement for other apps, like Signal, etc

  environment.etc = {
    xkeysnail_super = {
      target = "xkeysnail/super.py";
      text = ''
        import re
        from xkeysnail.transform import *

        define_keymap(re.compile("librewolf"), {
            K("Super-a"): K("C-a"),
            K("Super-c"): K("C-c"),
            K("Super-f"): K("C-f"),
            K("Super-l"): K("C-l"),
            K("Super-Shift-p"): K("C-Shift-p"),
            K("Super-q"): K("C-q"),
            K("Super-r"): K("C-r"),
            K("Super-t"): K("C-t"),
            K("Super-Shift-t"): K("C-Shift-t"),
            K("Super-v"): K("C-v"),
            K("Super-w"): K("C-w"),
            K("Super-x"): K("C-x"),
            K("Super-z"): K("C-z"),
            K("Super-Shift-z"): K("C-Shift-z"),
        }, "Librewolf")
      '';
    };
  };

  # For asgard we remap Alt, but then we swap Super (Win) and Alt so the effect is the same, except
  # we want to swap the Alt and Super keys so that it's more like a mac keyboard.
  environment.etc = {
    xkeysnail_alt = {
      target = "xkeysnail/alt.py";
      text = ''
        import re
        from xkeysnail.transform import *

        define_keymap(re.compile("librewolf"), {
            K("Alt-a"): K("C-a"),
            K("Alt-c"): K("C-c"),
            K("Alt-f"): K("C-f"),
            K("Alt-l"): K("C-l"),
            K("Alt-Shift-p"): K("C-Shift-p"),
            K("Alt-q"): K("C-q"),
            K("Alt-r"): K("C-r"),
            K("Alt-t"): K("C-t"),
            K("Alt-Shift-t"): K("C-Shift-t"),
            K("Alt-v"): K("C-v"),
            K("Alt-w"): K("C-w"),
            K("Alt-x"): K("C-x"),
            K("Alt-z"): K("C-z"),
            K("Alt-Shift-z"): K("C-Shift-z"),
        }, "Librewolf")
      '';
    };
  };

  systemd.services.xkeysnail = {
    enable = true;
    wantedBy = ["display-manager.service"];
    environment = {DISPLAY = ":0";};
    serviceConfig = {
      ExecStart = lib.mkDefault "${pkgs.xkeysnail}/bin/xkeysnail /etc/xkeysnail/super.py";
      User = "root";
      Restart = "always";
      RestartSec = "2";
    };
  };
}
