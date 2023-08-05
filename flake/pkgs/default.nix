{
  systems = [ "x86_64-linux" ];

  perSystem = { pkgs, ... }: {
    packages = {
      # instant repl with automatic flake loading
      repl = pkgs.callPackage ./repl { };

      xwaylandvideobridge =
        pkgs.libsForQt5.callPackage ./xwaylandvideobridge { };
    };
  };
}