{self, ...}: {
  flake.nixosModules.lenix-config = {
    config,
    pkgs,
    ...
  }: {
    boot = {
      binfmt.emulatedSystems = ["x86_64-linux"];
      extraModprobeConfig = "options hid_apple iso_layout=0";
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
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.nvim-qwerty];
    hardware = {
      asahi.peripheralFirmwareDirectory = pkgs.requireFile {
        hash = "sha256-ich1SH/YkuDja91ln/PcD0/Oe6Zb5uxGhWIBCeYaHvc=";
        hashMode = "recursive";
        message = "Please run 'nix-store --add-fixed sha256 --recursive /boot/vendorfw' to add the firmware.";
        name = "vendorfw";
      };
      sensor.iio.enable = true;
    };
    networking.hostName = "lenix";
    nix.settings = {
      cores = 4;
      http-connections = 30;
      max-jobs = 1;
      secret-key-files = [config.security.nix-secrets.secrets."nix-cache-key".path];
    };
    nix.settings.extra-platforms = ["x86_64-linux"];
    programs = {
      iio-hyprland.enable = true;
      nh.flake = "/persistent/dotfiles";
    };
    security.nix-secrets = {
      identityPaths = ["/persistent/nix-keys/age-identity.txt"];
      storagePath = "/persistent/dotfiles/secrets";
    };
    systemd.tmpfiles.rules = [
      "L+ /var/lib/iwd/eduroam.8021x - - - - ${
        config.security.nix-secrets.secrets."connor/wifi/eduroam".path
      }"
    ];
    time.timeZone = "Europe/Amsterdam";

    # Wireshark Course
    programs.wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
    users.users.connor.extraGroups = ["wireshark"];

    users = {
      mutableUsers = false;
      users.connor.hashedPasswordFile = config.security.nix-secrets.secrets."connor/linux".path;
    };
  };
}
