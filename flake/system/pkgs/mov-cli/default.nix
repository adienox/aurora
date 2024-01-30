{ lib, python3, fetchPypi, mpv }:
python3.pkgs.buildPythonPackage rec {
  pname = "mov_cli";
  version = "1.5.7";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-B9cN51NZ0i8VUA8uQsqj7FJe2+zo3nYbG2c5npBrw60=";
  };

  patches = [ ./requirements.patch ];

  makeWrapperArgs = [ "--prefix" "PATH" ":" "${lib.getBin mpv}/bin" ];

  propagatedBuildInputs = with python3.pkgs; [
    poetry-core
    krfzf-py
    pycrypto
    setuptools
    httpx
    click
    beautifulsoup4
    colorama
    six
    tldextract
  ];
}
