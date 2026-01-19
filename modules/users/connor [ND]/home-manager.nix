{ pkgs, ... }:
{
  flake.modules.homeManager.user-connor = {
    home.username = "connor";
    home.stateVersion = "25.11";

    home.packages = [ pkgs.htop ];

    programs.git = {
      enable = true;
      userName = "Connor";
      userEmail = "you@example.com";
    };
  };
}
