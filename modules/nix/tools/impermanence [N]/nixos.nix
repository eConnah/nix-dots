{ inputs, ... }:
{
  flake.modules.nixos.tool-impermanence = {
    imports = [ inputs.impermanence.nixosModules.impermanence ];
  };
}
