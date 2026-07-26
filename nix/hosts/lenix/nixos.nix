{ self, ... }: {
  flake.nixosModules.lenix-config = { pkgs, ... }: {
    networking.hostName = "lenix";

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
      "/nix" = {
        neededForBoot = true;
        options = [
          "compress=zstd"
          "noatime"
        ];
      };
      "/persistent" = {
        neededForBoot = true;
        options = [
          "compress=zstd"
          "noatime"
        ];
      };

      "/".options = [
        "size=25%"
        "mode=755"
      ];
      "/swap".options = [ "noatime" ];
    };

    # Asahi-Host Specifics
    hardware.asahi.peripheralFirmwareDirectory = pkgs.requireFile {
      name = "vendorfw";
      hashMode = "recursive";
      hash = "sha256-ich1SH/YkuDja91ln/PcD0/Oe6Zb5uxGhWIBCeYaHvc=";
      message = "Please run 'nix-store --add-fixed sha256 --recursive /boot/vendorfw' to add the firmware.";
    };
    boot.extraModprobeConfig = "options hid_apple iso_layout=0";

    # iio stuff
    hardware.sensor.iio.enable = true;
    programs.iio-hyprland.enable = true;

    # NH root
    programs.nh.flake = "/persistent/dotfiles";

    users = {
      mutableUsers = false;
      users.connor.hashedPasswordFile = "/persistent/passwords/connor";
    };

    boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
    nix.settings.extra-platforms = [ "x86_64-linux" ];

    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.nvim-qwerty ];

    nix.settings = {
      cores = 4;
      http-connections = 30;
      max-jobs = 1;
      secret-key-files = "/persistent/nix-keys/secret-key.pem";
    };

    time.timeZone = "Europe/London";

    system.stateVersion = "25.11"; # NEVER CHANGE
  };
}
