{
  config,
  pkgs,
  lib,
  ...
}: {
  stylix = {
    autoEnable = true;

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
  };
}
