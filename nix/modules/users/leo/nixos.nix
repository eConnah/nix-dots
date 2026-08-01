{ self, ... }: {
  flake.nixosModules.leo = { pkgs, ... }: {
    home-manager.users.leo = self.homeModules.leo;

    users = {
      groups.leo = {
        gid = 2006;
      };

      users.leo = {
        description = "Leo Chittock";
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        group = "leo";
        isNormalUser = true;
        shell = pkgs.fish;
        uid = 2006;
      };
    };
  };
}
