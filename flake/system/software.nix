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
    auto-cpufreq
    pciutils
    usbutils
    powertop
    polkit_gnome
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

  services = {
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
    auto-cpufreq.enable = true;
    openssh.enable = true;
    udisks2.enable = true;
    gvfs.enable = true; # Nautilus Trash
    gnome.sushi.enable = true; # Nautilus file preview
    fstrim.enable = true; # For SSD/NVME

    xserver = {
      layout = "us";
      xkbVariant = "";
    };
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
