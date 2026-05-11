{ inputs, self, ... }:
{
  flake.nixosConfigurations.onyx = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.catppuccin
      self.nixosModules.connor
      self.nixosModules.defaults
      self.nixosModules.hyprland
      self.nixosModules.limine
      self.nixosModules.nvidia
      self.nixosModules.onyxConfig
      self.nixosModules.onyxDisko
      self.nixosModules.onyxHardware
      self.nixosModules.onyxHome
      self.nixosModules.onyxPreservation
    ];
  };

  flake.nixosModules.onyxHome =
    { ... }:
    {
      imports = [ inputs.home-manager.nixosModules.default ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };

      home-manager.users.connor.imports = [
        self.homeModules.onyxHypr
        self.homeModules.swaybg
      ];

      home-manager.sharedModules = [
        self.homeModules.defaults
        self.homeModules.neovim
      ];
    };

  flake.nixosModules.onyxConfig =
    { pkgs, ... }:
    {
      networking.hostName = "onyx";
      users.users.connor.initialPassword = "password";

      zramSwap = {
        enable = true;
        memoryPercent = 25;
      };

      # NH root
      programs.nh.flake = "/persistent/dotfiles";

      system.stateVersion = "25.11"; # NEVER CHANGE
    };
}
