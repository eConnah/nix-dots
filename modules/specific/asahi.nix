{ inputs, self, ... }:
{
  flake.nixosModules.asahi =
    { lib, ... }:
    {
      imports = [
        self.nixosModules.defaults
      ];
      boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
    };
}
