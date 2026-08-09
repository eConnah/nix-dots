{ self, ... }: {
  flake.nixosModules.ewan = { pkgs, ... }: {
    imports = [ self.nixosModules.ewan-preservation ];
    home-manager.users.ewan = self.homeModules.ewan;
    users = {
      groups.ewan = {
        gid = 2000;
      };

      users.ewan = {
        description = "Ewan Alecks";
        extraGroups = [
          "wheel"
          "networkmanager"
          "dialout"
          "uucp"
        ];
        group = "ewan";
        isNormalUser = true;
        shell = pkgs.fish;
        uid = 2000;
      };
    };
  };
}
