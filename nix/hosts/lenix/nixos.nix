{ self, ... }: {
  flake.nixosModules.lenix-config = { pkgs, ... }: {
    boot = {
      initrd.kernelModules = [ "lz4" ];
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
    boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
    boot.extraModprobeConfig = "options hid_apple iso_layout=0";
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.nvim-qwerty ];
    fileSystems = {
      "/".options = [
        "size=25%"
        "mode=755"
      ];
      "/nix" = {
        options = [
          "compress=zstd"
          "noatime"
        ];
        neededForBoot = true;
      };
      "/persistent" = {
        options = [
          "compress=zstd"
          "noatime"
        ];
        neededForBoot = true;
      };
      "/swap".options = [ "noatime" ];
    };
    # Asahi-Host Specifics
    hardware.asahi.peripheralFirmwareDirectory = pkgs.requireFile {
      hash = "sha256-ich1SH/YkuDja91ln/PcD0/Oe6Zb5uxGhWIBCeYaHvc=";
      hashMode = "recursive";
      message = "Please run 'nix-store --add-fixed sha256 --recursive /boot/vendorfw' to add the firmware.";
      name = "vendorfw";
    };
    # iio stuff
    hardware.sensor.iio.enable = true;
    networking.hostName = "lenix";
    nix.settings = {
      cores = 4;
      http-connections = 30;
      max-jobs = 1;
      secret-key-files = "/persistent/nix-keys/secret-key.pem";
    };
    nix.settings.extra-platforms = [ "x86_64-linux" ];
    programs.iio-hyprland.enable = true;
    # NH root
    programs.nh.flake = "/persistent/dotfiles";
    swapDevices = [ { device = "/swap/swapfile"; } ];
    system.stateVersion = "25.11"; # NEVER CHANGE
    time.timeZone = "Europe/London";
    users = {
      mutableUsers = false;
      users.connor.hashedPasswordFile = "/persistent/passwords/connor";
    };
  };
}
