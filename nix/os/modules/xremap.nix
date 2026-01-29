{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.xremap-flake.nixosModules.default ];

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
