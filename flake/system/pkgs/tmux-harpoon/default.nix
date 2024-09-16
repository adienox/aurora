{
  stdenvNoCC,
  fetchFromGitHub,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "tmux-harpoon";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "Chaitanyabsprip";
    repo = pname;
    rev = "abc448eb7b66957a533b5e70b2b65e884ddeece5";
    hash = "sha256-+IakWkPoQFhIQ4m/98NVYWe5tFKmtfKBnPXZcfU9iOk=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp harpoon $out/bin
  '';
}
