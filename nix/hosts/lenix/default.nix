{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.lenix = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.asahi
      self.nixosModules.catppuccin
      self.nixosModules.connor
      self.nixosModules.defaults
      self.nixosModules.hyprland
      self.nixosModules.laptops
      self.nixosModules.lenixConfig
      self.nixosModules.lenixHardware
      self.nixosModules.lenixHome
      self.nixosModules.lenixPreservation
      self.nixosModules.limine
    ];
  };

  flake.nixosModules.lenixHome = { pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.default ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";

      sharedModules = [
        self.homeModules.defaults
      ];

      users.connor = {
        imports = [
          self.homeModules.lenixHypr
          self.homeModules.swaybg
        ];

        home.packages = with pkgs; [
          #(plezy.override { use16kPagesizeWorkaround = true; })
          (chromium.override { enableWideVine = true; })
          moonlight-qt
        ];

        theme.wallpaper = "frieren-01.png";
      };
    };
  };

  flake.nixosModules.lenixConfig = { pkgs, ... }: {
    networking.hostName = "lenix";

    boot.initrd.kernelModules = [ "lz4" ];

    boot.kernelParams = [
      "zswap.compressor=lz4"
      "zswap.enabled=1"
      "zswap.max_pool_percent=20"
      "zswap.shrinker_enabled=1"
    ];

    boot.kernel.sysctl = {
      "vm.swappiness" = 70;
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
      name = "asahi";
      hashMode = "recursive";
      hash = "sha256-jZ1nHCLnncRIMkoveGRspuhT9dVPchPmOvKXshihN4U=";
      message = "Please run 'nix-store --add-fixed sha256 --recursive /boot/asahi' to add the firmware.";
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

    system.stateVersion = "25.11"; # NEVER CHANGE
  };
}
