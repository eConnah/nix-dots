{ inputs, ... }:
{
  flake.modules.nixos.system-default = {
    imports = [ inputs.self.modules.generic.system-default ];
    
    system.stateVersion = "25.11"; 
    time.timeZone = inputs.nixpkgs.lib.mkDefault "UTC"; 
  };
}
