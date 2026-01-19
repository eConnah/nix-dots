{ inputs, ... }:
{
  flake.nixosConfigurations = inputs.self.lib.mkNixos "aarch64-linux" "le-nix";
}