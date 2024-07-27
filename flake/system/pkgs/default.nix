final: prev: {
  xwaylandvideobridge = prev.libsForQt5.callPackage ./xwaylandvideobridge {};
  win11-icon-theme = prev.callPackage ./win11-icon-theme {};
  # udiskie = prev.callPackage ./udiskie { };
  anipy-cli = prev.callPackage ./anipy-cli {};
  mov-cli = prev.callPackage ./mov-cli {};
  apple-fonts = prev.callPackage ./fonts/apple-fonts.nix {};
}
