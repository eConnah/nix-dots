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
          ];
        };
        "connor/linux" = {
          neededForUsers = true;
          recipients = [
            "lenix"
            "ACE"
            "murtle"
            "onyx"
          ];
        };
      };
    };
    connor-eduroam = {
      security.nix-secrets.secrets."connor/wifi/eduroam".recipients = [ "lenix" ];
    };
  };
}
