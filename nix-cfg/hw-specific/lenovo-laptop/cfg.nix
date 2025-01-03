{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.networkmanager.wifi.backend = "iwd";

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
     pciutils 
     usbutils
     wirelesstools
  ];

  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  boot.kernelModules = [ "kvm-intel" "wl" ];
  boot.initrd.kernelModules = [ "wl" ];

  # hardware.enableRedistributableFirmware= true;
  # hardware.broadcom43xx.enable = true;

  # boot.kernelModules = [ "bcma-pci-bridge" ];

  #environment.systemPackages = with pkgs; [
  #  broadcom-bt-firmware
  #  # broadcom_sta
  #];
}
