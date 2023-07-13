{ config,lib, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 3;
      grub = {
        enable = true;
        devices = ["nodev"];
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

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      nerdfonts
      font-awesome
      google-fonts
      source-han-sans
    ];
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
    nameservers = ["1.1.1.1"];
    networkmanager.enable = true;
    networkmanager.insertNameservers = ["1.1.1.1"];
  };

  # Open ports in the firewall.
  # Or disable the firewall altogether.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22000 ];
    allowedUDPPorts = [ ];
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
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    packages = with pkgs; [];
  };

  # Make sure opengl is enabled
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  # Tell Xorg to use the nvidia driver
  services.xserver.videoDrivers = ["nvidia"];

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
    git
    gnome.gnome-keyring
    seatd
    xdg-utils
    auto-cpufreq
    pciutils
    usbutils
    powertop
    libsForQt5.polkit-kde-agent
    python3Full
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

  programs.kdeconnect.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
  };
  environment.shells = with pkgs; [ zsh ];

  security = {
    polkit.enable = true;
    pam.services.swaylock = {
        text = ''
        auth include login
        '';
    };
  };

  services = {
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
    auto-cpufreq.enable = true;
    openssh.enable = true;
    udisks2.enable = true;

    locate = {
      enable = true;
      locate = pkgs.mlocate;
      localuser = null;
    };
  };
  xdg.portal.enable = true;

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  boot = {
      extraModprobeConfig =''
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
  systemd.tmpfiles.rules = map
          (e:
          "w /sys/bus/${e}/power/control - - - - auto"
          ) [
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
      channel  = "https://nixos.org/channels/nixos-unstable";
    };
  };
}
