{self, ...}: {
  flake.nixosModules.kyla = {pkgs, ...}: {
    imports = with self.nixosModules; [
      kyla-preservation
      oledppuccin
      self.secretModules.kyla
    ];
    hjem = {
      users.kyla = {
        imports = with self.hjemModules; [kyla];
        enable = true;
        directory = "/home/kyla";
        user = "kyla";
      };
    };
    services = {
      tailscale = {
        enable = true;
        useRoutingFeatures = "client";
      };
    };
    users = {
      groups.kyla = {
        gid = 2001;
      };

      users.kyla = {
        description = "Kyla Alecks";
        extraGroups = [
          "wheel"
          "networkmanager"
          "dialout"
          "uucp"
        ];
        group = "kyla";
        isNormalUser = true;
        shell = pkgs.fish;
        uid = 2001;
      };
    };
  };
}
