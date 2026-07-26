{ self, ... }: {
  flake.nixosModules.leo = { pkgs, ... }: {
    home-manager.users.leo = self.homeModules.leo;

    users = {
      groups.leo = {
        gid = 2006;
      };

      users.leo = {
        isNormalUser = true;
        description = "Leo Chittock";
        uid = 2006;
        group = "leo";
        shell = pkgs.fish;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
      };
    };
  };
}
