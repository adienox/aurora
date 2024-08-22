{pkgs, ...}: {
  imports = [./rnnoise.nix ./newsboat.nix ./mpv.nix];

  home.packages = with pkgs; [
    # audio control
    pavucontrol
    pulseaudio
    playerctl
    pulsemixer
    # xwaylandvideobridge

    # images
    imv
  ];

  services = {playerctld.enable = true;};
}
