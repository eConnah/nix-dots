{ inputs, ... }:
{
  flake.modules.darwin.user-connor = { pkgs, ... }: {
    imports = [ inputs.self.modules.darwin.home-manager ];

    users.users.connor = {
      home = "/Users/connor";
    };

    home-manager.users.connor = {
      imports = [ inputs.self.modules.homeManager.user-connor ];
    };
  };
}
