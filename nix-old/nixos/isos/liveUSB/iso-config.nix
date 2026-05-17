# iso-config.nix
{ config, pkgs, ... }:

{
  imports = [
    ../../hardware-configuration.nix
    <apple-silicon-support/apple-silicon-support>
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
  ];

  boot.extraModprobeConfig = ''
    options hid_apple iso_layout=0
  '';
  
  boot.zfs.package = pkgs.zfs_unstable;
  boot.supportedFilesystems = [ "btrfs" "squashfs" "vfat" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.initrd.systemd.enable = true;
  nixpkgs.config.allowUnsupportedSystem = true;

  boot.initrd.kernelModules = [ "squashfs" "overlay" "loop" ];
  boot.initrd.supportedFilesystems = [ "btrfs" "squashfs" "vfat" ];

  networking.networkmanager.enable = true;
  networking.hostName = "nix-live";
  time.timeZone = "Europe/Amsterdam";

  # Include minimal system packages
  environment.systemPackages = with pkgs; [
    btrfs-progs
    usbutils
    wget
    gh
    neovim
  ];
}
