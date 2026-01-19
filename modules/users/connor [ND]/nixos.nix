{ inputs, ... }:
{
  flake.modules.nixos.user-connor = {
    imports = [ inputs.self.modules.nixos.home-manager ];

    users.users.connor = {
      isNormalUser = true;
      description = "Connor";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = inputs.pkgs.zsh; 
    };
    
    programs.zsh.enable = true;

    home-manager.users.connor = {
      imports = [ inputs.self.modules.homeManager.user-connor ];
    };
  };
}
