# The system setup for le-nix (connor-macbook)

{
  inputs,
  lib,
  pkgs,
  pkgs-x86,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/de-hyprland.nix
    ../../modules/nixos/laptop.nix
  ];

  boot.kernelParams = [
    "zswap.enabled=1"
    "zswap.compressor=lz4"
    "zswap.max_pool_percent=20"
    "zswap.shrinker_enabled=1"
  ];

  boot.kernel.sysctl = {
    "vm.swappiness" = 70;
  };

  swapDevices = [ { device = "/swap/swapfile"; } ];

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [
      "compress=zstd"
      "noatime"
    ];
    "/swap".options = [ "noatime" ];
    "/var/log".options = [ "compress=zstd" ];
    "/var/cache".options = [ "noatime" ];
  };

  services.libinput.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    distrobox
    matugen
    gh
    brightnessctl
    e2fsprogs
    liblc3
    mpv
    plex-mpv-shim
    jellyfin-mpv-shim
    (catppuccin-sddm.override {
      flavor = "mocha";
      accent = "mauve";
      font = "Noto Sans";
      fontSize = "9";
    })
  ];
  
  boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
  nix.settings.extra-platforms = [ "x86_64-linux" ];

  system.stateVersion = "25.11"; # NEVER CHANGE
}
