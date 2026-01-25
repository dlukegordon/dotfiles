{
  config,
  pkgs,
  pkgsUnstable,
  inputs,
  ...
}:
{
  # Syncthing
  services.syncthing = {
    enable = true;
    package = pkgsUnstable.syncthing;
    overrideDevices = true;
    overrideFolders = true;
    user = "luke";
    dataDir = "/home/luke";
    configDir = "/home/luke/.config/syncthing";
    openDefaultPorts = true;
    settings = {
      devices = {
        "valhalla" = {
          id = "RNXQNX3-OEIBMA5-X5YE4Y7-4QIP6RM-ITEA2BW-2NMWR5L-EMU2QOH-ID25NQZ";
          addresses = [ "tcp://valhalla" ];
        };
        "asgard" = {
          id = "5BOX5PF-5CNBDTT-3UZTBVS-Q3FDMJU-CUU76JM-JMISICU-SKXH26N-IEGRTQJ";
          addresses = [ "tcp://asgard" ];
        };
        "nidavellir" = {
          id = "IQYSSBJ-S6XZ6HO-2R7DCGL-YM6WCFM-AKZYLQO-METIGNE-KZGVZJ4-26PX5AI";
          addresses = [ "tcp://nidavellir" ];
        };
        "zfold7" = {
          id = "SRQHVGH-AZAZDIF-K5U3KBV-XKGDD4F-4NHQDJI-HCY2ZLM-FIQ2Q7H-GBEDEAQ";
          addresses = [ "tcp://zfold7" ];
        };
      };
      folders = {
        "scratch" = {
          path = "/home/luke/scratch";
          devices = [
            "valhalla"
            "asgard"
            "nidavellir"
            "zfold7"
          ];
          versioning = {
            type = "trashcan";
            params = {
              cleanoutDays = "30";
            };
          };
        };
        "pictures" = {
          path = "/home/luke/Pictures";
          devices = [
            "valhalla"
            "asgard"
            "nidavellir"
            "zfold7"
          ];
          versioning = {
            type = "trashcan";
            params = {
              cleanoutDays = "30";
            };
          };
        };
        "keepass" = {
          path = "/home/luke/keepass";
          devices = [
            "valhalla"
            "asgard"
            "nidavellir"
            "zfold7"
          ];
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600"; # Clean interval in seconds (1 hour)
              maxAge = "31536000"; # Keep versions for 1 year (in seconds)
            };
          };
        };
      };
    };
  };
}
