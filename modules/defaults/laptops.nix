{ inputs, self, ... }:
{
  flake.nixosModules.laptops =
    { pkgs, lib, ... }:
    {
      imports = [
        self.nixosModules.defaults
      ];

      powerManagement.enable = true;
      services.logind.settings.Login.HandleLidSwitch = lib.mkDefault "suspend-then-hibernate";
      services.power-profiles-daemon.enable = true;
      hardware.bluetooth.enable = true;

      environment.systemPackages = with pkgs; [
        brightnessctl
      ];
    };
}
