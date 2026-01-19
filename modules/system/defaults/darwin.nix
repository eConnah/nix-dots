{ inputs, ... }:
{
  flake.modules.darwin.system-default = {
    imports = [ inputs.self.modules.generic.system-default ];
    
    system.stateVersion = 6;
  };
}
