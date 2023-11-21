self: super: {
  xwaylandvideobridge = self.libsForQt5.callPackage ./xwaylandvideobridge { };
  win11-icon-theme = self.callPackage ./win11-icon-theme { };
  udiskie = self.callPackage ./udiskie { };
  todoist-electron = self.callPackage ./todoist-electron { };
}
