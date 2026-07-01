{ ... }: {
  flake.nixosModules.insecure = { ... }: {
    nixpkgs.config.permittedInsecurePackages = [
      "pnpm-10.29.2"
    ];
  };
}
