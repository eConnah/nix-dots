{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.escapepod3 = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      asahi
      escapepod3-config
      escapepod3-hardware
      escapepod3-hjem
      hyprland
      leo
      limine
      lix
    ];
  };
}
