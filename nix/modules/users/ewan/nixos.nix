{ self, ... }: {
  flake.nixosModules.ewan = { pkgs, ... }: {
    imports = with self.nixosModules; [
      ewan-preservation
      oledppuccin
      self.secretModules.ewan
    ];
    hjem = {
      users.ewan = {
        imports = with self.hjemModules; [ ewan ];
        enable = true;
        directory = "/home/ewan";
        user = "ewan";
      };
    };
    programs.ydotool.enable = true;
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
          "dialout"
          "networkmanager"
          "uucp"
          "wheel"
          "ydotool"
        ];
        group = "ewan";
        isNormalUser = true;
        shell = pkgs.fish;
        uid = 2000;
      };
    };
  };
}
