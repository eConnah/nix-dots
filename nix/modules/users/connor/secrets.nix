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
            "yubikey"
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
            "yubikey"
          ];
        };
      };
    };
    connor-eduroam = {
      security.nix-secrets.secrets."connor/wifi/eduroam".recipients = [ "lenix" ];
    };
  };
}
