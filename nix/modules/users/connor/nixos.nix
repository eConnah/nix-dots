{ self, ... }: {
  flake = {
    nixosModules.connor = { pkgs, ... }: {
      imports = [ self.nixosModules.connor-preservation ];

      home-manager.users.connor = self.homeModules.connor;

      users.users.connor = {
        description = "Connor Alecks";
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [
          "wheel"
          "networkmanager"
          "dialout"
          "uucp"
        ];
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

      environment.systemPackages = with pkgs; [
        yubikey-manager
      ];
    };
  };
}
