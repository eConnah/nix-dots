{ inputs, ... }:
{
  flake.modules.generic.home-manager-settings = {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
  };
}
