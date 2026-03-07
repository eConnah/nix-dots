{ inputs, self, ... }:
{
  flake.nixosModules.nvidia =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.defaults
      ];
    };
}
