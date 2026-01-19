{ inputs, ... }:
{
  flake.modules.darwin.user-connor = {
    imports = [ inputs.self.modules.darwin.home-manager ];

    users.users.connor = {
      home = "/Users/connor";
      shell = inputs.pkgs.zsh;
    };

    home-manager.users.connor = {
      imports = [ inputs.self.modules.homeManager.user-connor ];
    };
  };
}
