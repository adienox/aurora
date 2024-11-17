{ pkgs, inputs, ... }:
{
  imports = [
    ./rnnoise.nix
    ./newsboat.nix
    ./mpv.nix
  ];

  home.packages = with pkgs; [
    # audio control
    inputs.pavucontrol-6.legacyPackages.${pkgs.system}.pavucontrol
    pulseaudio
    playerctl
    pulsemixer
    # xwaylandvideobridge

    # images
    imv

    ffmpeg
  ];

  services = {
    playerctld.enable = true;
  };
}
