{ inputs, ... }:
{
  flake.modules.nixos.tool-disko = {
    imports = [ inputs.disko.nixosModules.disko ];
  };
}
