{
  flake.secretModules = {
    connor-headless = {
      security.nix-secrets.secrets = {
        "connor/linux" = {
          neededForUsers = true;
          recipients = [
            "ACE"
            "cookie"
            "lenix"
            "murtle"
            "onyx"
            "phoenix"
            "turtle"
            "yubikey"
          ];
        };
      };
    };
    connor-graphical = {
      security.nix-secrets.secrets = {
        "connor/halloy" = {
          group = "connor";
          owner = "connor";
          recipients = [
            "ACE"
            "cookie"
            "lenix"
            "murtle"
            "onyx"
            "turtle"
            "yubikey"
          ];
        };
      };
    };
    connor-eduroam = {
      security.nix-secrets.secrets."connor/wifi/eduroam".recipients = ["lenix" "yubikey"];
    };
  };
}
