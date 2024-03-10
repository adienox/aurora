self: super: {
  xwaylandvideobridge = self.libsForQt5.callPackage ./xwaylandvideobridge { };
  win11-icon-theme = self.callPackage ./win11-icon-theme { };
  udiskie = self.callPackage ./udiskie { };
  anipy-cli = self.callPackage ./anipy-cli { };
  mov-cli = self.callPackage ./mov-cli { };
  apple-fonts = self.callPackage ./fonts/apple-fonts.nix { };
}
