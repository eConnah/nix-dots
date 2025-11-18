# The system setup for le-nix (connor-macbook)

{ inputs, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/de-hyprland.nix
    ../../modules/nixos/laptop.nix
  ];
  
  networking.hostName = "le-nix";

  boot.kernelParams = [
    "zswap.enabled=1"
    "zswap.compressor=lz4"
    "zswap.max_pool_percent=20"
    "zswap.shrinker_enabled=1"
  ];

  swapDevices = [ { device = "/swap/swapfile"; } ];
  
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    "/swap".options = [ "noatime" ];
    "/var/log".options = [ "compress=zstd" ];
    "/var/cache".options = [ "noatime" ];
  };
  
  services.gnome.gnome-keyring.enable = true;
  services.libinput.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    distrobox
    wget
    kitty
    matugen
    usbutils
    gh
    brightnessctl
    e2fsprogs
    p7zip
    easyeffects
    pulseaudio
    liblc3
    pavucontrol
    mpv
    plex-mpv-shim
    (catppuccin-sddm.override {
      flavor = "mocha";
      accent = "mauve";
      font  = "Noto Sans";
      fontSize = "9";
    })
  ];
  
  hardware.graphics.package = inputs.fix.legacyPackages.aarch64-linux.mesa;
  system.stateVersion = "25.11"; # NEVER CHANGE
}
