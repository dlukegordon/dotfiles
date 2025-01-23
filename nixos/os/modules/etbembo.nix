{
  stdenv,
  fetchurl,
  lib,
}:
stdenv.mkDerivation {
  pname = "et-bembo";
  version = "1.0";

  srcs = [
    (fetchurl {
      url = "https://raw.githubusercontent.com/edwardtufte/et-book/refs/heads/gh-pages/et-book/et-book-roman-line-figures/et-book-roman-line-figures.ttf";
      name = "et-book-roman-line-figures.ttf";
      sha256 = "48a4c0e333ea34f975702a965db80c29bc831f215c3606f47b3fe14f53d0f638";
    })
    (fetchurl {
      url = "https://raw.githubusercontent.com/edwardtufte/et-book/refs/heads/gh-pages/et-book/et-book-display-italic-old-style-figures/et-book-display-italic-old-style-figures.ttf";
      name = "et-book-display-italic-old-style-figures.ttf";
      sha256 = "fcc87c657ecac7efbba1776a16a1ccf60189d93819579be11af60984a7ab99bd";
    })
    (fetchurl {
      url = "https://raw.githubusercontent.com/edwardtufte/et-book/refs/heads/gh-pages/et-book/et-book-bold-line-figures/et-book-bold-line-figures.ttf";
      name = "et-book-bold-line-figures.ttf";
      sha256 = "38cc5ee305a8d9e6dc1a1f0266af6746b6ac4c85ca2f77b051594a1f7dc3e426";
    })
  ];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    for f in $srcs; do
      cp $f $out/share/fonts/truetype/$(basename $f)
    done
  '';

  meta = with lib; {
    description = "ET Book font family - Edward Tufte's book fonts";
    homepage = "https://github.com/edwardtufte/et-book";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
