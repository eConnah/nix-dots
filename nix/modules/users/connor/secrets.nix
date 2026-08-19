{
  flake.secretModules = {
    connor = {
      security.nix-secrets.secrets = {
        "connor/halloy" = {
          group = "connor";
          owner = "connor";
          recipients = [
            "lenix"
            "ACE"
            "murtle"
            "onyx"
            "cookie"
          ];
        };
        "connor/linux" = {
          neededForUsers = true;
          recipients = [
            "lenix"
            "ACE"
            "murtle"
            "onyx"
            "cookie"
          ];
        };
      };
    };
    connor-eduroam = {
      security.nix-secrets.secrets."connor/wifi/eduroam".recipients = [ "lenix" ];
    };
  };
}
