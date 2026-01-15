{
  config,
  pkgs,
  pkgsUnstable,
  ...
}:
{
  system.stateVersion = "24.11"; # Did you read the comment?

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

  # Get latest kernel in the channel
  boot.kernelPackages = pkgs.linuxPackages_latest;

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
  time.timeZone = "America/Chicago";
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Dbus
  services.dbus.implementation = "broker";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.luke = {
    isNormalUser = true;
    description = "Luke";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
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

  # Tailscale
  services.tailscale = {
    enable = true;
    package = pkgsUnstable.tailscale;
    useRoutingFeatures = "client";
  };

  # Gitea
  services.gitea = {
    enable = true;
    package = pkgsUnstable.gitea;
    settings = {
      server.HTTP_PORT = 3000;
    };
  };
  networking.firewall.allowedTCPPorts = [ 3000 ];

  # Hack to stop a warning during nix build
  # TODO: Setup real alerts for issues with RAID?
  boot.swraid = {
    # Already enabled in hardware_configuration.nix
    mdadmConf = ''
      MAILADDR someone@example.com
    '';
  };

  environment.systemPackages = with pkgs; [
    btop
    cmake
    fastfetch
    fd
    fzf
    gcc
    git
    gnumake
    gnupg
    inetutils
    less
    lsof
    mosh
    pkgsUnstable.bat
    pkgsUnstable.carapace
    pkgsUnstable.neovim
    pkgsUnstable.nushell
    pkgsUnstable.ov
    ripgrep
    starship
    stow
    tmux
    unzip
    usbutils
    wget
    zoxide
  ];

}
