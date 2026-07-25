{ self, ... }: {
  flake.nixosModules.leo = { pkgs, ... }: {
    home-manager.users.leo = self.homeModules.leo;

    users.users.leo = {
      isNormalUser = true;
      description = "Leo Chittock";
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };
  };
}
