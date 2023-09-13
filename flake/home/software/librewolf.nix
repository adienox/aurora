{...}: {
  programs.librewolf = {
    enable = true;
    settings = {
      "privacy.webrtc.hideGlobalIndicator" = true;
      "identity.fxaccounts.enable" = true;
    };
  };
}
