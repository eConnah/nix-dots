{ inputs, ... }:
{
  flake.modules.darwin.home-manager = {
    imports = [ 
      inputs.home-manager.darwinModules.home-manager
      inputs.self.modules.generic.home-manager-settings
    ];
  };
}
