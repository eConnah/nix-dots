{ self, ... }: {
  flake.nixosModules.ewan = { pkgs, ... }: {
    imports = with self.nixosModules; [ ewan-preservation ];
    hjem = {
      users.ewan = {
        imports = with self.hjemModules; [ ewan ];
        enable = true;
        directory = "/home/ewan";
        user = "ewan";
      };
    };
    services = {
      tailscale = {
        enable = true;
        useRoutingFeatures = "client";
      };
    };
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
