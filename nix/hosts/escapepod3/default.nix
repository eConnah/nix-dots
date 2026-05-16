{ inputs, self, ... }:
{
  flake.nixosConfigurations.escapepod3 = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.asahi
      self.nixosModules.catppuccin
      self.nixosModules.defaults
      self.nixosModules.escapepod3Config
      self.nixosModules.escapepod3Hardware
      self.nixosModules.escapepod3Home
      self.nixosModules.hyprland
      self.nixosModules.laptops
      self.nixosModules.leo
      self.nixosModules.limine
    ];
  };

  flake.nixosModules.escapepod3Home =
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

        users.leo = {
          imports = [
            self.homeModules.escapepod3Hypr
            self.homeModules.escapepod3Panel
            self.homeModules.swaybg
          ];

          home.packages = with pkgs; [
            #(plezy.override { use16kPagesizeWorkaround = true; })
          ];
        };
      };
    };

  flake.nixosModules.escapepod3Config =
    { pkgs, ... }:
    {
      networking.hostName = "escapepod3";

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
      programs.nh.flake = "/home/leo/Documents/dotfiles";

      boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
      nix.settings.extra-platforms = [ "x86_64-linux" ];

      system.stateVersion = "25.11"; # NEVER CHANGE
    };
}
