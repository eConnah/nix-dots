{self, ...}: {
  flake.nixosModules.evilix-hjem = {lib, ...}: {
    hjem.users.clementine = {
      imports = with self.hjemModules; [
        oledppuccin
        remote-assets
      ];
      rum.programs = {
        direnv = {
          enable = true;
          integrations = {
            fish.enable = true;
            nix-direnv.enable = true;
          };
        };
        fish.enable = true;
        git = {
          settings = lib.mkForce {};
          ignore = ''
            NuGet.config
          '';
        };
      };
      xdg.config.files = {
        "jj/config.toml".enable = false;
      };
    };
  };
}
