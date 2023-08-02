{ config, lib, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

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
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_QPA_PLATFORM = "xcb obs";
    #https://unix.stackexchange.com/a/657578
    LIBSEAT_BACKEND = "logind";
  };

  # Using https://github.com/samuelngs/apple-emoji-linux Apple Color Emoji as the default emoji font. Download and place it in ~$HOME/.local/share/fonts~
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [ nerdfonts font-awesome google-fonts source-han-sans ];
    fontconfig.defaultFonts.emoji = [ "Apple Color Emoji" ];
  };

  hardware.bluetooth = {
    enable = true;
    settings.General.Experimental = true;
  };
  services.blueman.enable = true;

  time.timeZone = "Asia/Kathmandu";
  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "anomaly";
    networkmanager.enable = true;

    nameservers = [ "94.140.14.14" "94.140.15.15" "1.1.1.1" ];
    networkmanager.insertNameservers = [ "94.140.14.14" "94.140.15.15" "1.1.1.1" ];

    firewall = {
      enable = true;
      allowedTCPPorts = [ 22000 ];
      allowedUDPPorts = [ ];
      allowedTCPPortRanges = [{
        from = 1714;
        to = 1764;
      }]; # Needed for KDE connect
      allowedUDPPortRanges = [{
        from = 1714;
        to = 1764;
      }]; # Needed for KDE connect
    };
  };
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  users.users.nox = {
    isNormalUser = true;
    description = "adienox";
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
    discord
  ];

  # Enable adbusers in extragroups for user
  programs.adb.enable = true;

  nixpkgs.overlays = [
    (final: prev: {
      discord = prev.discord.override {
        withOpenASAR = true;
        withVencord = true;
      };
    })
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland = {
      hidpi = true;
      enable = true;
    };
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

  # Power Management
  # Disable Watchdogs [[https://wiki.archlinux.org/title/Improving_performance#Watchdogs][Blacklist SP5100]] [[https://wiki.archlinux.org/title/Power_management#Disabling_NMI_watchdog][NMI Watchdog]]
  # Enabling powersave on [[https://wiki.archlinux.org/title/Power_management#Network_interfaces][network interfaces]]
  # Enabling powersave on [[https://wiki.archlinux.org/title/Power_management#Intel_wireless_cards_(iwlwifi)][Iwlwifi]]
  # Enabling powersave on [[https://wiki.archlinux.org/title/Power_management#Audio][Audio]]
  # Enabling powersave on pci devices [[https://github.com/NixOS/nixpkgs/issues/211345#issuecomment-1397825573][Github Issue]]
  # Increasing virtual memory [[https://wiki.archlinux.org/title/Power_management#Writeback_Time][Writeback time]]
  boot = {
    extraModprobeConfig = ''
      options iwlwifi power_save=1
      options iwlmvm power_scheme=3
      options snd_hda_intel power_save=1
      blacklist sp5100_tco
    '';
    kernel.sysctl = {
      "kernel.nmi_watchdog" = 0;
      "vm.dirty_writeback_centisecs" = 1500;
      "vm.laptop_mode" = 5;
    };
  };
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="net", KERNEL=="wl*", RUN+="${pkgs.iw}/bin/iw dev $name set power_save on"
  '';
  systemd.tmpfiles.rules =
    map (e: "w /sys/bus/${e}/power/control - - - - auto") [
      "pci/devices/0000:00:00.0" # Root Complex
      "pci/devices/0000:00:00.2" # IOMMU
      "pci/devices/0000:00:01.0" # Renoir PCIe Dummy Host Bridge
      "pci/devices/0000:00:02.0" # Renoir PCIe Dummy Host Bridge
      "pci/devices/0000:00:08.0" # Renoir PCIe Dummy Host Bridge
      "pci/devices/0000:00:14.0" # FCH SMBus Controller
      "pci/devices/0000:00:14.3" # FCH LPC bridge
      "pci/devices/0000:00:18.0" # Renoir Function 0
      "pci/devices/0000:00:18.1" # Renoir Function 1
      "pci/devices/0000:00:18.2" # Renoir Function 2
      "pci/devices/0000:00:18.3" # Renoir Function 3
      "pci/devices/0000:00:18.4" # Renoir Function 4
      "pci/devices/0000:00:18.5" # Renoir Function 5
      "pci/devices/0000:00:18.6" # Renoir Function 6
      "pci/devices/0000:00:18.7" # Renoir Function 7
      "pci/devices/0000:01:00.0" # Nvidia GPU
      "pci/devices/0000:02:00.0" # Non-Volatile Memory Controller
      "pci/devices/0000:03:00.0" # Ethernet
      "pci/devices/0000:04:00.0" # Wifi
      "pci/devices/0000:05:00.0" # VGA controller
      "pci/devices/0000:05:00.2" # Encryption controller
      "pci/devices/0000:05:00.3" # Renoir/Cezanne USB 3.1
      "pci/devices/0000:05:00.5" # Audio co-processor
      "pci/devices/0000:05:00.6" # Audio controller
      "pci/devices/0000:06:00.0" # FCH SATA Controller [AHCI mode]
      "pci/devices/0000:06:00.1" # FCH SATA Controller [AHCI mode]
      "pci/devices/0000:06:00.0/ata1" # FCH SATA Controller [AHCI mode]
      "pci/devices/0000:06:00.1/ata2" # FCH SATA Controller [AHCI mode]
      "usb/devices/3-3" # USB device 3-3
      "usb/devices/3-4" # ITE device
    ];

  # systemd.tmpfiles.rules = map
  #         (e:
  #         "w /sys/class/scsi_host/${e}/link_power_management_policy - - - - med_power_with_dipm"
  #         ) [
  #           "host0" # Sata link power management Host0
  #           "host1" # Sata link power management Host1
  #         ];

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
