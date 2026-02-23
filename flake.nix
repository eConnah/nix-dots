{
  description = "Connors NixOS Dendritic Flake";

  inputs = {
    # =================== Nix Stuff ===================
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # =================================================

    # =================== Other Flakes ===================
    vicinae.url = "github:vicinaehq/vicinae"; # To use cache do NOT follow nixpkgs
    # ====================================================

    # =================== Asahi Support ===================
    apple-silicon = {
      url = "github:nix-community/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # =====================================================
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; }
      (inputs.import-tree ./modules);
}
