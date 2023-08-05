{ config, lib, pkgs, ... }:
let
  user = "adienox";
  username = "nox";
in
{
  imports = [
    ./hardware-configuration.nix
    ./power-management.nix
    ./networking.nix
    ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 3;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        useOSProber = false;
        efiSupport = true;
        configurationLimit = 5;
      };
    };
  };

  environment.variables = {
    #https://unix.stackexchange.com/a/657578
    LIBSEAT_BACKEND = "logind";
  };

  # Using https://github.com/samuelngs/apple-emoji-linux Apple Color Emoji as the default emoji font. Download and place it in ~$HOME/.local/share/fonts~
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [ nerdfonts font-awesome google-fonts ];
    fontconfig.defaultFonts.emoji = [ "Apple Color Emoji" ];
  };

  hardware.bluetooth = {
    enable = true;
    settings.General.Experimental = true;
  };
  services.blueman.enable = true;

  time.timeZone = "Asia/Kathmandu";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  users.users.${username} = {
    isNormalUser = true;
    description = user;
    shell = pkgs.zsh;
    extraGroups =
      [ "networkmanager" "wheel" "video" "audio" "adbusers" "input" ];
    packages = with pkgs; [ ];
  };

  # Make sure opengl is enabled
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  # Tell Xorg to use the nvidia driver
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is needed for most wayland compositors
    modesetting.enable = true;

    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    open = true;

    # Enable the nvidia settings menu
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    iw
    killall
    wget
    seatd
    xdg-utils
    auto-cpufreq
    pciutils
    usbutils
    powertop
    polkit_gnome
    python3Full
    gnome.nautilus
  ];

  # Enable adbusers in extragroups for user
  programs.adb.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.shells = with pkgs; [ zsh ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
  };

  security = {
    polkit.enable = true;
    pam.services.gtklock = {
      text = ''
        auth include login
      '';
    };
    sudo.extraConfig = ''
      Defaults env_reset,pwfeedback
    '';
    pam.services.nox.enableGnomeKeyring = true;
  };

  services = {
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
    auto-cpufreq.enable = true;
    openssh.enable = true;
    udisks2.enable = true;
    gvfs.enable = true; # Nautilus Trash
    gnome.sushi.enable = true; # Nautilus file preview

    locate = {
      enable = true;
      locate = pkgs.mlocate;
      localuser = null;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
  xdg.portal.enable = true;

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
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

  system = {
    stateVersion = "23.05";
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };
}
