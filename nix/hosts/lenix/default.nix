{ inputs, self, ... }:
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
      self.nixosModules.limine
    ];
  };

  flake.nixosModules.lenixHome =
    { pkgs, ... }:
    {
      imports = [ inputs.home-manager.nixosModules.default ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        sharedModules = [
          self.homeModules.defaults
          self.homeModules.neovim
        ];

        users.connor = {
          imports = [
            self.homeModules.lenixHypr
            self.homeModules.lenixPanel
            self.homeModules.swaybg
          ];

          home.packages = with pkgs; [
            #(plezy.override { use16kPagesizeWorkaround = true; })
            moonlight-qt
          ];
        };
      };
    };

  flake.nixosModules.lenixConfig =
    { pkgs, ... }:
    {
      networking.hostName = "lenix";

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
        hash = "sha256-jZ1nHCLnncRIMkoveGRspuhT9dVPchPmOvKXshihN4U=";
        message = "Please run 'nix-store --add-fixed sha256 --recursive /boot/asahi' to add the firmware.";
      };
      boot.extraModprobeConfig = "options hid_apple iso_layout=0";

      # iio stuff
      hardware.sensor.iio.enable = true;
      programs.iio-hyprland.enable = true;

      # NH root
      programs.nh.flake = "/home/connor/Documents/dotfiles";

      boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
      nix.settings.extra-platforms = [ "x86_64-linux" ];

      system.stateVersion = "25.11"; # NEVER CHANGE
    };
}
