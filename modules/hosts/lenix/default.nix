{ inputs, self, ... }:
{
  flake.nixosConfigurations.lenix = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.lenixHardware
      self.nixosModules.lenixConfig
      self.nixosModules.lenixHypr
      self.nixosModules.connor
      self.nixosModules.limine
      self.nixosModules.catppuccin
      self.nixosModules.asahi
    ];

    home-manager.sharedModules = [
      self.homeModules.vicinae
    ];
  };

  flake.nixosModules.lenixConfig =
    { pkgs, ... }:
    {
      networking.hostName = "lenix";

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

      # List packages installed in system profile.
      # You can use https://search.nixos.org/ to find more packages (and options).
      environment.systemPackages = with pkgs; [
        distrobox
        matugen
        e2fsprogs
        liblc3
        plex-mpv-shim
        jellyfin-mpv-shim
        obsidian
      ];

      boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
      nix.settings.extra-platforms = [ "x86_64-linux" ];

      system.stateVersion = "25.11"; # NEVER CHANGE
    };
}
