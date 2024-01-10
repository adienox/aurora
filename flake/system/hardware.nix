{ config, ... }: {
  hardware.bluetooth = {
    enable = true;
    settings.General.Experimental = true;
  };

  services.blueman.enable = true;

  # settings for xremap to work
  hardware.uinput.enable = true;
  users.groups.uinput.members = [ "nox" ];
  users.groups.input.members = [ "nox" ];

  # Tell Xorg to use the nvidia driver
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    # Make sure opengl is enabled
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    nvidia = {
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
  };
}
