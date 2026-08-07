{ self, ... }: {
  flake = {
    nixosModules.connor = { pkgs, ... }: {
      imports = [ self.nixosModules.connor-preservation ];
      environment.systemPackages = with pkgs; [
        yubikey-manager
      ];
      home-manager.users.connor = self.homeModules.connor;
      security.nix-secrets.secrets."passwords/connor/linux" = {
        neededForUsers = true;
        recipients = [ "lenix" ];
      };
      services = {
        displayManager.autoLogin.user = "connor";

        pcscd.enable = true;

        tailscale = {
          enable = true;
          useRoutingFeatures = "client";
        };
        udev.packages = with pkgs; [
          yubikey-personalization
        ];
      };
      users = {
        groups.connor = {
          gid = 2026;
        };

        users.connor = {
          description = "Connor Alecks";
          extraGroups = [
            "wheel"
            "networkmanager"
            "dialout"
            "uucp"
          ];
          group = "connor";
          isNormalUser = true;
          shell = pkgs.fish;
          uid = 2026;
        };
      };
    };
  };
}
