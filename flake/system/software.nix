{ pkgs, ... }: {

  nixpkgs = {
    config.allowUnfree = true;
    config.allowUnfreePredicate = (pkg: true);
    overlays = [ (import ./pkgs) ];
  };

  environment.systemPackages = with pkgs; [
    iw
    psmisc
    wget
    seatd
    xdg-utils
    pciutils
    usbutils
    powertop
    polkit_gnome
    libcamera
    docker-compose
    neovim
    git
    ntfs3g
  ];
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  # Enable adbusers in extragroups for user
  programs.adb.enable = true;

  nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    settings = { max-cache-ttl = 86400; };
  };

  environment.shells = with pkgs; [ zsh ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    shellInit = ''
      export ZDOTDIR="$HOME"/.config/zsh
    '';
  };

  # enable zsh autocompletion for system packages (systemd, etc)
  environment.pathsToLink = [ "/share/zsh" ];

  # setting the ~/.local/bin to be in path for every user
  environment.localBinInPath = true;

  services.cron = { enable = true; };

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  services = {
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
    openssh.enable = true;
    udisks2.enable = true;
    gvfs.enable = true; # Nautilus Trash
    gnome.sushi.enable = true; # Nautilus file preview

    tlp = {
      settings = {
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      };
    };

    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    locate = {
      enable = true;
      package = pkgs.mlocate;
      localuser = null;
      interval = "hourly";
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # Backlight control for video group
    # Xremap without sudo
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
      ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
      KERNEL=="uinput", GROUP="input", TAG+="uaccess"
    '';

    # needed for GNOME services outside of GNOME Desktop
    dbus.packages = [ pkgs.gcr ];
  };

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
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
