{ config, ... }: {
  hardware.bluetooth = { enable = true; };

  services = {
    blueman.enable = true;
    fstrim.enable = true; # For SSD/NVME
  };

  # settings for xremap to work
  hardware.uinput.enable = true;
  users.groups.uinput.members = [ "nox" ];
  users.groups.input.members = [ "nox" ];
}
