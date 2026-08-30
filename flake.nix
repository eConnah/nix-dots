{
  description = "Connors NixOS Dendritic Flake";

  inputs = {
    apple-silicon = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixos-apple-silicon";
    };
    disko = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/disko";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    hjem = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:feel-co/hjem";
    };
    hjem-rum = {
      inputs.hjem.follows = "hjem";
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:snugnug/hjem-rum";
    };
    import-tree.url = "github:denful/import-tree";
    lix = {
      flake = false;
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
    };
    lix-module = {
      inputs.lix.follows = "lix";
      inputs.nixpkgs.follows = "nixpkgs";
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
    };
    nix-secrets = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:unnamed-systems/nix-secrets";
    };
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    nvf = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:notashelf/nvf";
    };
    preservation.url = "github:nix-community/preservation";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./nix);
}
