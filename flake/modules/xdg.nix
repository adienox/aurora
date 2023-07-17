{ config, lib, pkgs, ... }:

{
  xdg.mimeApps.defaultApplications = {
    "image/*" = [ "imv.desktop" ];
    "video/*" = [ "mpv.desktop" ];
  };

  xdg.desktopEntries.keepassxc = {
    name = "KeepassXC (XCB)";
    genericName = "Password Manager";
    icon = "keepassxc";
    exec = "keepassxc -platform xcb %f";
    terminal = false;
    categories = [ "Utility" "Security" ];
    mimeType = [ "application/x-keepass2" ];
  };
}
