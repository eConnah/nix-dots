{ self, ... }: {
  flake = {
    nixosModules.ewan = { pkgs, ... }: {
      imports = [ self.nixosModules.ewan-preservation ];

      home-manager.users.ewan = self.homeModules.ewan;

      users = {
        groups.ewan = {
          gid = 2000;
        };

        users.ewan = {
          description = "Ewan Alecks";
          isNormalUser = true;
          uid = 2000;
          group = "ewan";
          shell = pkgs.fish;
          extraGroups = [
            "wheel"
            "networkmanager"
            "dialout"
            "uucp"
          ];
        };
      };
    };
  };
}
