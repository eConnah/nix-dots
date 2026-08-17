{ self, ... }: {
  flake.nixosModules.connor = { pkgs, ... }: {
    imports = with self.nixosModules; [
      catppuccin
      connor-preservation
    ];
    environment.systemPackages = with pkgs; [
      yubikey-manager
    ];
    hjem = {
      users.connor = {
        imports = with self.hjemModules; [ connor ];
        enable = true;
        directory = "/home/connor";
        user = "connor";
      };
    };
    security.nix-secrets.secrets."passwords/connor/linux" = {
      neededForUsers = true;
      recipients = [ "lenix" ];
    };
    services = {
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
}
