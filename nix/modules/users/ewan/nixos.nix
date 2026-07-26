{ self, ... }: {
  flake = {
    nixosModules.ewan = { pkgs, ... }: {
      imports = [ self.nixosModules.ewan-preservation ];

      home-manager.users.ewan = self.homeModules.ewan;

      users.users.ewan = {
        description = "Ewan Alecks";
        isNormalUser = true;
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
}
