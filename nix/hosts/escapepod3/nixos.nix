{self, ...}: {
  flake.nixosModules.escapepod3-config = {
    lib,
    pkgs,
    ...
  }: {
    boot = {
      initrd.kernelModules = ["lz4"];
      kernel.sysctl = {
        "vm.swappiness" = 70;
      };
      kernelParams = [
        "zswap.compressor=lz4"
        "zswap.enabled=1"
        "zswap.max_pool_percent=20"
        "zswap.shrinker_enabled=1"
      ];
    };
    boot.binfmt.emulatedSystems = ["x86_64-linux"];
    boot.extraModprobeConfig = "options hid_apple iso_layout=0";
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.nvim-qwerty];
    fileSystems = {
      "/".options = ["compress=zstd"];
      "/home".options = ["compress=zstd"];
      "/nix".options = [
        "compress=zstd"
        "noatime"
      ];
      "/swap".options = ["noatime"];
      "/var/cache".options = ["noatime"];
      "/var/log".options = ["compress=zstd"];
    };
    # Asahi-Host Specifics
    hardware.asahi.peripheralFirmwareDirectory = pkgs.requireFile {
      hash = "sha256-X2XGA984LlJILJtRHEDXWTiJ6A/rqEE3NHXwkoCMAwI=";
      hashMode = "recursive";
      message = "Please run 'nix-store --add-fixed sha256 --recursive /boot/asahi' to add the firmware.";
      name = "asahi";
    };
    # iio stuff
    hardware.sensor.iio.enable = true;
    networking.hostName = "escapepod3";
    nix.settings = {
      cores = 4;
      max-jobs = 2;
    };
    nix.settings.extra-platforms = ["x86_64-linux"];
    programs.iio-hyprland.enable = true;
    # NH root
    programs.nh.flake = "/home/leo/Documents/dotfiles";
    security.nix-secrets.enable = lib.mkForce false;
    swapDevices = [{device = "/swap/swapfile";}];
    time.timeZone = "Europe/London";
  };
}
