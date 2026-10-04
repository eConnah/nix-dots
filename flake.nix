{
  description = "Connors NixOS Dendritic Flake";

  outputs = {self, ...} @ args: let
    # flake-parts fix
    inputs = (import ./.tack) {
      overrides = args.tackOverrides or {};
    };
  in
    inputs.flake-parts.lib.mkFlake {
      inherit inputs;
      self =
        self
        // {
          inherit inputs;
        };
    } (inputs.import-tree ./nix);
}
