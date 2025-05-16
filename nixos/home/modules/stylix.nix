{
  config,
  pkgs,
  lib,
  ...
}: {
  stylix = {
    autoEnable = false;

    fonts = {
      sizes.applications = 10;
      sizes.popups = 16;
      sizes.desktop = 7;

      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };

      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
    };

    targets = {
      fuzzel.enable = true;
      hyprpaper.enable = true;
      waybar.enable = true;
    };
  };
}
