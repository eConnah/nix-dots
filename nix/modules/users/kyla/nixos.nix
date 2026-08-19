{ self, ... }: {
  flake.nixosModules.kyla = { pkgs, ... }: {
    imports = with self.nixosModules; [
      kyla-preservation
      oledppuccin
    ];
    hjem = {
      users.kyla = {
        imports = with self.hjemModules; [ kyla ];
        enable = true;
        directory = "/home/kyla";
        user = "kyla";
      };
    };
    security.nix-secrets.secrets."passwords/kyla/linux" = {
      neededForUsers = true;
      recipients = [ "ACE" ];
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
        description = "kyla Alecks";
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
