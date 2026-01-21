{
  config,
  pkgs,
  pkgsUnstable,
  ...
}:
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

  # Booting
  boot = {
    consoleLogLevel = 3;
    initrd.verbose = false;
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = true;
    plymouth = {
      enable = true;
      theme = "script";
    };
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
      "plymouth.use-simpledrm"
    ];
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  # time.timeZone = "America/Chicago";
  # services.automatic-timezoned.enable = true;
  # services.geoclue2.geoProviderUrl = "https://api.beacondb.net/v1/geolocate";

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

  # Enable SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  environment.systemPackages = [
    (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
      [General]
      background=${pkgs.pop-hp-wallpapers}/share/backgrounds/pop-hp/flow-state-navy+gold-gradient.png
    '')
  ];

  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;

  # Kmscon
  services.kmscon = {
    enable = true;
    fonts = [
      {
        name = "JetBrains Mono";
        package = pkgs.jetbrains-mono;
      }
    ];
    extraConfig = "font-dpi=192";
  };

  # Dbus
  services.dbus.implementation = "broker";

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.luke = {
    isNormalUser = true;
    description = "Luke";
    extraGroups = [
      "input"
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKGh4an4vSJg76uIk1YpK2CfQxuFMtbDQ4aJMs+344vy"
    ];
    shell = pkgsUnstable.nushell;
  };
  security.sudo.wheelNeedsPassword = false;

  # Ssh
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = null;
      X11Forwarding = false;
    };
  };
  programs.mosh.enable = true;

  # Docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 42069 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
