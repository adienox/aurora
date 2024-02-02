{ pkgs, ... }: {
  imports = [ ./rnnoise.nix ./newsboat.nix ./mpv.nix ];

  home.packages = with pkgs; [
    # audio control
    pavucontrol
    playerctl
    pulsemixer

    youtube-music
    ani-cli
    mov-cli

    # images
    imv
  ];

  services = { playerctld.enable = true; };
}
