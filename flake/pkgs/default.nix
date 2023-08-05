{pkgs, ...}: {
  packages."x86_64-linux" = {
    xwaylandvideobridge =
      pkgs.libsForQt5.callPackage ./xwaylandvideobridge { };
  };
}