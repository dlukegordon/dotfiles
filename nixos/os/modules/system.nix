{
  config,
  pkgs,
  pkgsUnstable,
  ...
}:
let
  customSddmTheme = pkgs.stdenv.mkDerivation {
    name = "custom-where-is-my-sddm-theme";
    src = pkgs.where-is-my-sddm-theme;
    installPhase = ''
      mkdir -p $out/share/sddm/themes/where_is_my_sddm_theme
      cp -r $src/share/sddm/themes/where_is_my_sddm_theme/* $out/share/sddm/themes/where_is_my_sddm_theme/
      chmod u+w $out/share/sddm/themes/where_is_my_sddm_theme/theme.conf
      cp $out/share/sddm/themes/where_is_my_sddm_theme/example_configs/blue.conf \
       $out/share/sddm/themes/where_is_my_sddm_theme/theme.conf
      echo "hideCursor=true" >> $out/share/sddm/themes/where_is_my_sddm_theme/theme.conf
      sed -i 's/showUsersByDefault=false/showUsersByDefault=true/' \
        $out/share/sddm/themes/where_is_my_sddm_theme/theme.conf
      sed -i 's/showSessionsByDefault=false/showSessionsByDefault=true/' \
        $out/share/sddm/themes/where_is_my_sddm_theme/theme.conf
      sed -i 's/backgroundFill=#8aadf4/backgroundFill=#252623/' \
        $out/share/sddm/themes/where_is_my_sddm_theme/theme.conf
      sed -i 's/basicTextColor=#ffffff/basicTextColor=#f1e9d2/' \
        $out/share/sddm/themes/where_is_my_sddm_theme/theme.conf
      sed -i 's/passwordInputBackground=#7b9fe7/passwordInputBackground=#383b35/' \
        $out/share/sddm/themes/where_is_my_sddm_theme/theme.conf
      sed -i 's/property string prevText: "<"/property string prevText: ""/' \
        $out/share/sddm/themes/where_is_my_sddm_theme/SessionsChoose.qml
      sed -i 's/property string nextText: ">"/property string nextText: ""/' \
        $out/share/sddm/themes/where_is_my_sddm_theme/SessionsChoose.qml
      sed -i 's/property string prevText: "<"/property string prevText: ""/' \
        $out/share/sddm/themes/where_is_my_sddm_theme/UsersChoose.qml
      sed -i 's/property string nextText: ">"/property string nextText: ""/' \
        $out/share/sddm/themes/where_is_my_sddm_theme/UsersChoose.qml
    '';
  };
in
{
  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Automatic updates
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  # Automatic cleanup
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 10d";
  nix.settings.auto-optimise-store = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  # time.timeZone = "America/Chicago";
  services.automatic-timezoned.enable = true;
  services.geoclue2.geoProviderUrl = "https://api.beacondb.net/v1/geolocate";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;
  environment.etc."/xdg/menus/applications.menu".text =
    builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  # Enable SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "${customSddmTheme}/share/sddm/themes/where_is_my_sddm_theme";
  };
  services.displayManager.defaultSession = "niri";
  services.displayManager.sessionPackages = [
    pkgsUnstable.niri
    pkgsUnstable.hyprland
  ];

  # Window Managers
  programs.hyprland = {
    enable = true;
    package = pkgsUnstable.hyprland;
    withUWSM = true;
  };
  programs.niri = {
    enable = true;
    package = pkgsUnstable.niri;
  };
  security.pam.services.sddm.enableKwallet = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.ELECTRON_OZONE_PLATFORM_HINT = "auto";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Bluetooth support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.luke = {
    isNormalUser = true;
    description = "Luke";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
    ];
    shell = pkgsUnstable.nushell;
  };
  security.sudo.wheelNeedsPassword = false;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 42069 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
