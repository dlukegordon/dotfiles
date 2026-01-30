{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.xremap-flake.nixosModules.default ];

  # Stop xremap when graphical session ends so it starts fresh on next login
  systemd.user.services.xremap.unitConfig = {
    PartOf = [ "graphical-session.target" ];
  };

  # Restart xremap when keyboard devices are added/removed
  # This fixes the issue where xremap gets into a broken state after USB hot-plug
  services.udev.extraRules = ''
    ACTION=="add|remove", SUBSYSTEM=="input", ENV{ID_INPUT_KEYBOARD}=="1", ATTR{name}!="*virtual*", ATTR{name}!="*ydotool*", ATTR{name}!="*xremap*", TAG+="systemd", ENV{SYSTEMD_USER_WANTS}="xremap-restart.service"
  '';

  systemd.user.services.xremap-restart = {
    description = "Restart xremap after keyboard hot-plug";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/systemctl --user restart xremap.service";
      # Delay slightly to let the device settle
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 1";
    };
  };

  services.xremap = {
    enable = true;
    serviceMode = "user";
    userName = "luke";
    withKDE = true;
    config = {
      modmap = [ ];
      keymap = [
        {
          name = "Mac-like shortcuts";
          application = {
            not = [ "com.mitchellh.ghostty" ];
          };
          remap = {
            "Super-c" = "C-c";
            "Super-Shift-c" = "C-Shift-c";
            "Super-d" = "C-d";
            "Super-Shift-d" = "C-Shift-d";
            "Super-v" = "C-v";
            "Super-Shift-v" = "C-Shift-v";
            "Super-x" = "C-x";
            "Super-Shift-x" = "C-Shift-x";
            "Super-z" = "C-z";
            "Super-Shift-z" = "C-Shift-z";
            "Super-a" = "C-a";
            "Super-Shift-a" = "C-Shift-a";
            "Super-s" = "C-s";
            "Super-Shift-s" = "C-Shift-s";
            "Super-f" = "C-f";
            "Super-Shift-f" = "C-Shift-f";
            "Super-g" = "C-g";
            "Super-Shift-g" = "C-Shift-g";
            "Super-h" = "C-h";
            "Super-Shift-h" = "C-Shift-h";
            "Super-l" = "C-l";
            "Super-Shift-l" = "C-Shift-l";
            "Super-n" = "C-n";
            "Super-Shift-n" = "C-Shift-n";
            "Super-o" = "C-o";
            "Super-Shift-o" = "C-Shift-o";
            "Super-w" = "C-w";
            "Super-Shift-w" = "C-Shift-w";
            "Super-t" = "C-t";
            "Super-Shift-t" = "C-Shift-t";
            "Super-r" = "C-r";
            "Super-Shift-r" = "C-Shift-r";
            "Super-p" = "C-p";
            "Super-Shift-p" = "C-Shift-p";
            "Super-k" = "C-k";
            "Super-Shift-k" = "C-Shift-k";
            "Super-b" = "C-b";
            "Super-Shift-b" = "C-Shift-b";
            "Super-i" = "C-i";
            "Super-Shift-i" = "C-Shift-i";
            "Super-j" = "C-j";
            "Super-Shift-j" = "C-Shift-j";
            "Super-u" = "C-u";
            "Super-Shift-u" = "C-Shift-u";
            "Super-equal" = "C-equal";
            "Super-minus" = "C-minus";
            "Super-leftbrace" = "C-leftbrace";
            "Super-rightbrace" = "C-rightbrace";
          };
        }
      ];
    };
  };
}
