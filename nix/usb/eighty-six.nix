{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.eighty-six = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
      connor
      defaults
      mesa
      (
        {
          config,
          lib,
          ...
        }:
        {
          isoImage.squashfsCompression = "gzip -Xcompression-level 1";
          networking = {
            hostName = "nixos-iso";
            networkmanager = {
              enable = true;
              wifi.backend = "iwd";
            };
            wireless.enable = false;
          };
          preservation.enable = lib.mkForce false;
          security.nix-secrets.enable = lib.mkForce false;
          security.sudo.wheelNeedsPassword = false;
          services.flatpak.enable = lib.mkForce false;
          services.openssh.settings.PermitRootLogin = lib.mkForce "yes";
          users = {
            mutableUsers = lib.mkForce true;
            users = {
              connor.password = "nixos";
              root = {
                initialHashedPassword = lib.mkForce null;
                openssh.authorizedKeys.keys = config.users.users.connor.openssh.authorizedKeys.keys;
                password = "nixos";
              };
            };
          };
        }
      )
    ];
    system = "x86_64-linux";
  };
}
