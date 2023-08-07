{pkgs, ...}: {
  packages.${pkgs.system} = {
    xwaylandvideobridge =
      pkgs.libsForQt5.callPackage ./xwaylandvideobridge { };
  };
}