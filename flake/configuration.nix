{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 3;
      grub = {
        enable = true;
        devices = ["nodev"];
        useOSProber = true;
        efiSupport = true;
        configurationLimit = 5;
      };
    };
  };

  networking.hostName = "anomaly";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kathmandu";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nox = {
    isNormalUser = true;
    description = "adienox";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    killall
    wget
    git
    gnome.gnome-keyring
    seatd
    libsForQt5.polkit-kde-agent
  ];

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      nerdfonts
      font-awesome
      google-fonts
      source-han-sans
    ];
  };

  security.polkit.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
  };

  programs.kdeconnect.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland = {
      hidpi = true;
      enable = true;
    };
  };

  environment = {
    variables = {
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_QPA_PLATFORM = "xcb obs";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  xdg.portal.enable = true;
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  hardware = {
    bluetooth.enable = true;
  };

  # List services that you want to enable:
  services = {
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    locate = {
      enable = true;
      locate = pkgs.mlocate;
      localuser = null;
    };

    emacs = {
      enable = true;
      defaultEditor = true;
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #
  system.stateVersion = "23.05"; # Did you read the comment?
  system.autoUpgrade = {
    enable = true;
    channel  = "https://nixos.org/channels/nixos-unstable";
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
}
