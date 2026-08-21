{ self, ... }: {
  flake.nixosModules.ACE-config =
    {
      config,
      pkgs,
      ...
    }:
    {
      environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.nvim-qwerty ];
      hardware.sensor.iio.enable = true;
      networking.hostName = "ACE";
      nix.settings = {
        cores = 4;
        http-connections = 50;
        max-jobs = 1;
        secret-key-files = [ config.security.nix-secrets.secrets."nix-cache-key".path ];
      };
      programs.iio-hyprland.enable = true;
      programs.nh.flake = "/persistent/dotfiles";
      security.nix-secrets = {
        identityPaths = [ "/persistent/nix-keys/age-identity.txt" ];
        storagePath = "/persistent/dotfiles/secrets";
      };
      time.timeZone = "Europe/London";
      users = {
        mutableUsers = false;
        users = {
          connor.hashedPasswordFile = config.security.nix-secrets.secrets."connor/linux".path;
          kyla.hashedPasswordFile = config.security.nix-secrets.secrets."kyla/linux".path;
        };
      };
    };
}
