{
  flake.nixosModules.evilix-hjem = {pkgs, ...}: {
    hjem.users.connor = {
      packages = with pkgs; [
        spotify
      ];
    };
  };
}
