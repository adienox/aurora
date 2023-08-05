{ config, lib, pkgs, ... }:
let
  pciRules = map
    (e: "w /sys/bus/${e}/power/control - - - - auto")
    [
      "pci/devices/0000:00:00.0" # Root Complex
      "pci/devices/0000:00:00.2" # IOMMU
      "pci/devices/0000:00:01.0" # Renoir PCIe Dummy Host Bridge
      "pci/devices/0000:00:02.0" # Renoir PCIe Dummy Host Bridge
      "pci/devices/0000:00:08.0" # Renoir PCIe Dummy Host Bridge
      "pci/devices/0000:00:14.0" # FCH SMBus Controller
      "pci/devices/0000:00:14.3" # FCH LPC bridge
      "pci/devices/0000:00:18.0" # Renoir Function 0
      "pci/devices/0000:00:18.1" # Renoir Function 1
      "pci/devices/0000:00:18.2" # Renoir Function 2
      "pci/devices/0000:00:18.3" # Renoir Function 3
      "pci/devices/0000:00:18.4" # Renoir Function 4
      "pci/devices/0000:00:18.5" # Renoir Function 5
      "pci/devices/0000:00:18.6" # Renoir Function 6
      "pci/devices/0000:00:18.7" # Renoir Function 7
      "pci/devices/0000:01:00.0" # Nvidia GPU
      "pci/devices/0000:02:00.0" # Non-Volatile Memory Controller
      "pci/devices/0000:03:00.0" # Ethernet
      "pci/devices/0000:04:00.0" # Wifi
      "pci/devices/0000:05:00.0" # VGA controller
      "pci/devices/0000:05:00.2" # Encryption controller
      "pci/devices/0000:05:00.3" # Renoir/Cezanne USB 3.1
      "pci/devices/0000:05:00.5" # Audio co-processor
      "pci/devices/0000:05:00.6" # Audio controller
      "pci/devices/0000:06:00.0" # FCH SATA Controller [AHCI mode]
      "pci/devices/0000:06:00.1" # FCH SATA Controller [AHCI mode]
      "pci/devices/0000:06:00.0/ata1" # FCH SATA Controller [AHCI mode]
      "pci/devices/0000:06:00.1/ata2" # FCH SATA Controller [AHCI mode]
      "usb/devices/3-3" # USB device 3-3
      "usb/devices/3-4" # ITE device
    ];
  scsiRules = map
    (e:
      "w /sys/class/scsi_host/${e}/link_power_management_policy - - - - med_power_with_dipm"
    )
    [
      "host0" # Sata link power management Host0
      "host1" # Sata link power management Host1
    ];
in
{
  # Power Management
  # Disable Watchdogs [[https://wiki.archlinux.org/title/Improving_performance#Watchdogs][Blacklist SP5100]] [[https://wiki.archlinux.org/title/Power_management#Disabling_NMI_watchdog][NMI Watchdog]]
  # Enabling powersave on [[https://wiki.archlinux.org/title/Power_management#Network_interfaces][network interfaces]]
  # Enabling powersave on [[https://wiki.archlinux.org/title/Power_management#Intel_wireless_cards_(iwlwifi)][Iwlwifi]]
  # Enabling powersave on [[https://wiki.archlinux.org/title/Power_management#Audio][Audio]]
  # Enabling powersave on pci devices [[https://github.com/NixOS/nixpkgs/issues/211345#issuecomment-1397825573][Github Issue]]
  # Increasing virtual memory [[https://wiki.archlinux.org/title/Power_management#Writeback_Time][Writeback time]]
  boot = {
    extraModprobeConfig = ''
      options iwlwifi power_save=1
      options iwlmvm power_scheme=3
      options snd_hda_intel power_save=1
      blacklist sp5100_tco
    '';
    kernel.sysctl = {
      "kernel.nmi_watchdog" = 0;
      "vm.dirty_writeback_centisecs" = 1500;
      "vm.laptop_mode" = 5;
    };
  };
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="net", KERNEL=="wl*", RUN+="${pkgs.iw}/bin/iw dev $name set power_save on"
  '';
  systemd.tmpfiles.rules = pciRules ++ scsiRules;
}
