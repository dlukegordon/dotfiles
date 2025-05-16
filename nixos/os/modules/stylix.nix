{
  config,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    autoEnable = false;
    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/qz/wallhaven-qz7qyr.jpg";
      sha256 = "14473c001ce0c128f8bbd1f352adbb2a7f211bdb24c24f159c2444787dcd13c1";
    };
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml";
  };
  environment.etc."pictures/wallpaper.jpg".source = config.stylix.image;
}
