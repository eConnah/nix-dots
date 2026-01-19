{ inputs, ... }:
{
  flake.modules.nixos.user-connor =
    { pkgs, ... }:
    {
      imports = [
        inputs.self.modules.nixos.home-manager
        (inputs.self.shell.fish "connor")
      ];

      users.users.connor = {
        isNormalUser = true;
        description = "Connor";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };

      time.timeZone = inputs.nixpkgs.lib.mkDefault "Europe/Amsterdam";

      home-manager.users.connor = {
        imports = [ inputs.self.modules.homeManager.user-connor ];
      };
    };
}
