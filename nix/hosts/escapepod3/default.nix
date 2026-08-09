{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.escapepod3 = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      asahi
      catppuccin
      defaults
      escapepod3-config
      escapepod3-hardware
      escapepod3-home
      hyprland
      laptops
      leo
      limine
    ];
  };
}
