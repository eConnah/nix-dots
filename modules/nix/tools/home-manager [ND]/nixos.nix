{ inputs, ... }:
{
  flake.modules.nixos.home-manager = {
    imports = [ 
      inputs.home-manager.nixosModules.home-manager
      inputs.self.modules.generic.home-manager-settings
    ];
  };
}
