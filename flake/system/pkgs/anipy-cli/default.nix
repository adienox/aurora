{ python310, fetchPypi }:
let
  better-ffmpeg-progress = (python310.pkgs.buildPythonPackage rec {
    pname = "better-ffmpeg-progress";
    version = "2.1.2";

    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-E2p9DDoWhf5USWhbPA33gnrb0vIkByZggBNI4TSnotg=";
    };

    doCheck = false;

    nativeBuildInputs = with python310.pkgs; [ setuptools wheel ];

    propagatedBuildInputs = with python310.pkgs; [ tqdm ffmpeg-python ];
  });

  python-mpv = (python310.pkgs.buildPythonPackage rec {
    pname = "python-mpv";
    version = "1.0.5";
    pyproject = true;

    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-kFPr8FxYGBChz/bFSS1RbqRlA53ArCSsd3nuIcd31l0=";
    };

    doCheck = false;

    nativeBuildInputs = with python310.pkgs; [ setuptools wheel ];
  });

  yaspin = (python310.pkgs.buildPythonPackage rec {
    pname = "yaspin";
    version = "3.0.1";
    pyproject = true;

    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-nASqaczpvoPh6jE0pnEudJ5sDJzQJZkCNxPmvv1782k=";
    };

    doCheck = false;

    nativeBuildInputs = with python310.pkgs; [ poetry-core ];
    propagatedBuildInputs = with python310.pkgs; [ termcolor ];
  });

in python310.pkgs.buildPythonApplication rec {
  pname = "anipy_cli";
  version = "2.7.30";

  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-vqt0T9JCVhx6uh3J6cPbNx0L3Y6Pa1oQtRf+UNq8B8o=";
  };

  doCheck = false;

  nativeBuildInputs = with python310.pkgs; [ setuptools wheel ];

  propagatedBuildInputs = with python310.pkgs; [
    better-ffmpeg-progress
    pycryptodomex
    requests
    python-dateutil
    pypresence
    m3u8
    setuptools
    beautifulsoup4
    tqdm
    moviepy
    pyyaml
    python-mpv
    yaspin
  ];
}
