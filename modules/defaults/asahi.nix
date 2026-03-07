{ inputs, self, ... }:
{
  flake.nixosModules.asahi =
    { pkgs, lib, ... }:
    {
      imports = [
        self.nixosModules.laptops
      ];
      boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
      services.logind.settings.Login.HandleLidSwitch = lib.mkForce "ignore";
      environment.systemPackages = with pkgs; [
        asahi-bless
      ];
    };
}
