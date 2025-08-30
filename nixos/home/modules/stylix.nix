{
  config,
  pkgs,
  lib,
  ...
}:
{
  stylix = {
    autoEnable = false;

    fonts = {
      sizes.applications = 10;
      sizes.popups = 16;
      sizes.desktop = 11;

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
      gtk.enable = true;
      hyprpaper.enable = true;
      qt.enable = true;
      waybar.enable = true;
    };
  };
}
