{ inputs, ... }:
{
  flake.modules.generic.system-default = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.vim pkgs.git pkgs.wget ];
    
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    
    nixpkgs.config.allowUnfree = true;
  };
}
