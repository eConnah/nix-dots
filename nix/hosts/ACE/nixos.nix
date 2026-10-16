{moduleWithSystem, ...}: {
  flake.nixosModules.ACE-config = moduleWithSystem ({self', ...}: {config, ...}: {
    environment.systemPackages = [self'.packages.nvim-qwerty];
    hardware.sensor.iio.enable = true;
    networking.hostName = "ACE";
    nix.settings = {
      cores = 4;
      http-connections = 50;
      max-jobs = 1;
      secret-key-files = [config.security.nix-secrets.secrets."nix-cache-key".path];
    };
    programs.iio-hyprland.enable = true;
    programs.nh.flake = "/persistent/dotfiles";
    security.nix-secrets.identityPaths = ["/persistent/nix-keys/age-identity.txt"];
    time.timeZone = "Europe/London";
    users = {
      mutableUsers = false;
      users = {
        kyla.hashedPasswordFile = config.security.nix-secrets.secrets."kyla/linux".path;
      };
    };
  });
}
