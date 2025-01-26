{
  config,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    autoEnable = true;
    image = pkgs.fetchurl {
      url = "https://static.simpledesktops.com/uploads/desktops/2014/04/23/Black_Diamonds.png";
      sha256 = "8dae83893f7af20a2dd73eb78fffd5279508cbd1b1538a9a3988ea43b99abaf4";
    };
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml";
  };
}
