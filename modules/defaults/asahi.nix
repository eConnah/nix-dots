{ inputs, self, ... }:
{
  flake.nixosModules.asahi =
    { lib, ... }:
    {
      imports = [
        self.nixosModules.laptops
      ];
      boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
      services.logind.settings.Login.HandleLidSwitch = lib.mkForce "ignore";
    };
}
