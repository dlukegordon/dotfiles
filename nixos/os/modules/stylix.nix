{
  config,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    autoEnable = false;
    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/ml/wallhaven-mlq138.png";
      sha256 = "Hg485mkY1cuKFbaAeKUml5Gde8N/BBjH2f7vtjpfqZo=";
    };
    polarity = "dark";
    base16Scheme = ./bamboo.yaml;
  };
  environment.etc."pictures/wallpaper.jpg".source = config.stylix.image;
}
