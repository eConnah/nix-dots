{self, ...}: {
  flake.nixosModules = {
    connor-graphical = {pkgs, ...}: {
      imports = [
        self.nixosModules.connor-headless
        self.secretModules.connor-graphical
      ];
      environment.systemPackages = with pkgs; [
        yubikey-manager
      ];
      hjem.users.connor.imports = [self.hjemModules.connor-graphical];
      services = {
        pcscd.enable = true;
        udev.packages = with pkgs; [
          yubikey-personalization
        ];
      };
    };
    connor-headless = {pkgs, ...}: {
      imports = [
        self.nixosModules.connor-preservation
        self.nixosModules.oledppuccin
        self.secretModules.connor-headless
      ];
      hjem = {
        users.connor = {
          imports = [self.hjemModules.connor-headless];
          enable = true;
          directory = "/home/connor";
          user = "connor";
        };
      };
      services = {
        tailscale = {
          enable = true;
          useRoutingFeatures = "client";
        };
      };
      users = {
        groups.connor = {
          gid = 2026;
        };

        users.connor = {
          description = "Connor Alecks";
          extraGroups = [
            "dialout"
            "input"
            "la-famille"
            "uucp"
            "wheel"
          ];
          group = "connor";
          isNormalUser = true;
          linger = true;
          openssh.authorizedKeys.keys = [
            "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIILd7radoI+ZnYz/NKDVLBDH8zFdq6r2I/gP0HuZGs0gAAAABHNzaDo= ssh:"
          ];
          shell = pkgs.fish;
          uid = 2026;
        };
      };
    };
  };
}
