{
  inputs,
  self,
  ...
}:
{
  flake = {
    nixosConfigurations.phoenix = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        self.nixosModules.catppuccin
        self.nixosModules.connor
        self.nixosModules.defaults
        self.nixosModules.ewan
        self.nixosModules.hyprland
        self.nixosModules.insecure
        self.nixosModules.laptops
        self.nixosModules.limine
        self.nixosModules.lix
        self.nixosModules.mesa
        self.nixosModules.phoenix-config
        self.nixosModules.phoenix-disko
        self.nixosModules.phoenix-hardware
        self.nixosModules.phoenix-home
      ];
    };

    nixosModules.phoenix-home = { pkgs, ... }: {
      imports = [ inputs.home-manager.nixosModules.default ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";

        sharedModules = [
          self.homeModules.defaults
        ];

        users = {
          connor = {
            imports = [
              self.homeModules.phoenix-hyprland
              self.homeModules.swaybg
            ];

            home.packages = with pkgs; [
              plezy
            ];

            theme.wallpaper = "86-02.png";
          };

          ewan = {
            imports = [
              self.homeModules.phoenix-hyprland
              self.homeModules.swaybg
            ];

            home.packages = with pkgs; [
              plezy
            ];

            theme.wallpaper = "frieren-03.png";
          };
        };
      };
    };

    nixosModules.phoenix-config = { pkgs, ... }: {
      networking.hostName = "phoenix";

      # iio stuff
      hardware.sensor.iio.enable = true;
      programs.iio-hyprland.enable = true;

      # NH root
      programs.nh.flake = "/persistent/dotfiles";

      users = {
        mutableUsers = false;
        users.ewan.initialPassword = "tacobell";
        # users.ewan.hashedPasswordFile = "/persistent/passwords/ewan";
      };

      environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.nvim-qwerty ];

      nix.settings = {
        cores = 4;
        http-connections = 30;
        max-jobs = 1;
        # secret-key-files = "/persistent/nix-keys/secret-key.pem";
      };

      time.timeZone = "Europe/London";

      system.stateVersion = "25.11"; # NEVER CHANGE
    };
  };
}
