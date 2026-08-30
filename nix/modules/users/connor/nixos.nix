{self, ...}: {
  flake.nixosModules.connor = {pkgs, ...}: {
    imports = with self.nixosModules; [
      connor-preservation
      oledppuccin
      self.secretModules.connor
    ];
    environment.systemPackages = with pkgs; [
      yubikey-manager
    ];
    hjem = {
      users.connor = {
        imports = with self.hjemModules; [connor];
        enable = true;
        directory = "/home/connor";
        user = "connor";
      };
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
        openssh.authorizedKeys.keys = [
          "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIILd7radoI+ZnYz/NKDVLBDH8zFdq6r2I/gP0HuZGs0gAAAABHNzaDo= ssh:"
        ];
        shell = pkgs.fish;
        uid = 2026;
      };
    };
  };
}
