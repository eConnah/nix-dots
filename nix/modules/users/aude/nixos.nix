{self, ...}: {
  flake.nixosModules.aude = {pkgs, ...}: {
    imports = with self.nixosModules; [
      aude-preservation
      oledppuccin
      self.secretModules.aude
    ];
    hjem = {
      users.aude = {
        imports = with self.hjemModules; [aude];
        enable = true;
        directory = "/home/aude";
        user = "aude";
      };
    };
    services = {
      tailscale = {
        enable = true;
        useRoutingFeatures = "client";
      };
    };
    users = {
      groups.aude = {
        gid = 1220;
      };

      users.aude = {
        description = "Aude Alecks";
        extraGroups = [
          "wheel"
          "networkmanager"
          "dialout"
          "uucp"
        ];
        group = "aude";
        isNormalUser = true;
        shell = pkgs.fish;
        uid = 1220;
      };
    };
  };
}
