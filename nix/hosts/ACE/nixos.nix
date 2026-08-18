{ self, ... }: {
  flake.nixosModules.ACE-config = { pkgs, ... }: {
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.nvim-qwerty ];
    hardware.sensor.iio.enable = true;
    networking.hostName = "ACE";
    nix.settings = {
      cores = 4;
      http-connections = 50;
      max-jobs = 1;
    };
    programs.iio-hyprland.enable = true;
    programs.nh.flake = "/persistent/dotfiles";
    time.timeZone = "Europe/London";
    users = {
      mutableUsers = false;
      users = {
        connor.initialPassword = "tacobell";
      };
    };
  };
}
