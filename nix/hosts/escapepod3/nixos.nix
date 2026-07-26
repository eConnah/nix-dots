{ self, ... }: {
  flake.nixosModules.escapepod3-config = { pkgs, ... }: {
    networking.hostName = "escapepod3";

    boot = {
      initrd.kernelModules = [ "lz4" ];
      kernelParams = [
        "zswap.compressor=lz4"
        "zswap.enabled=1"
        "zswap.max_pool_percent=20"
        "zswap.shrinker_enabled=1"
      ];
      kernel.sysctl = {
        "vm.swappiness" = 70;
      };
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

    # Asahi-Host Specifics
    hardware.asahi.peripheralFirmwareDirectory = pkgs.requireFile {
      name = "asahi";
      hashMode = "recursive";
      hash = "sha256-X2XGA984LlJILJtRHEDXWTiJ6A/rqEE3NHXwkoCMAwI=";
      message = "Please run 'nix-store --add-fixed sha256 --recursive /boot/asahi' to add the firmware.";
    };
    boot.extraModprobeConfig = "options hid_apple iso_layout=0";

    # iio stuff
    hardware.sensor.iio.enable = true;
    programs.iio-hyprland.enable = true;

    # NH root
    programs.nh.flake = "/home/leo/Documents/dotfiles";

    boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
    nix.settings.extra-platforms = [ "x86_64-linux" ];

    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.nvim-qwerty ];

    nix.settings = {
      cores = 4;
      max-jobs = 2;
    };

    time.timeZone = "Europe/London";

    system.stateVersion = "25.11"; # NEVER CHANGE
  };
}
