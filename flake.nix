{
  description = "Connors NixOS Dendritic Flake";

  outputs = {self, ...} @ args: let
    # flake-parts fix
    inputs = (import ./.tack) {
      overrides = args.tackOverrides or {};
    };

    # join the hivemind
    assimilate = d:
      builtins.readDir d
      |> builtins.mapAttrs (name: type:
        if type == "directory"
        then assimilate (d + "/${name}")
        else [(d + "/${name}")])
      |> builtins.attrValues
      |> builtins.concatLists;
  in
    inputs.flake-parts.lib.mkFlake {
      inherit inputs;
      self =
        self
        // {
          inherit inputs;
        };
    } {imports = assimilate ./nix;};
}
