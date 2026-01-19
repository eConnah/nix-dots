{ inputs, ... }:
{
  flake.modules.generic.system-default = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.git pkgs.wget ];
    
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    
    nixpkgs.config.allowUnfree = true;

    home-manager.sharedModules = [
      inputs.nixvim.homeModules.nixvim
      inputs.self.modules.generic.nixvim-config
    ];
  };
}
