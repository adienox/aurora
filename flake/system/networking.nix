{...}: {
  networking = {
    hostName = "anomaly";
    networkmanager.enable = true;

    nameservers = ["94.140.14.14" "94.140.15.15" "1.1.1.1"];
    networkmanager.insertNameservers = ["94.140.14.14" "94.140.15.15" "1.1.1.1"];

    firewall = {
      enable = true;
      allowedTCPPorts = [
        1337
        22000 # syncthing
        8080 # anki
        9090 # calibre
        2222 # sftp
        5050
        4040
        5040
      ];
      allowedUDPPorts = [1337 8080 9090 2222];
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ]; # Needed for KDE connect
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ]; # Needed for KDE connect
    };
  };
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
