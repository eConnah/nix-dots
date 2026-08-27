{
  flake.secretModules = {
    ewan = {
      security.nix-secrets.secrets = {
        "ewan/linux" = {
          neededForUsers = true;
          recipients = [
            "murtle"
            "yubikey"
          ];
        };
      };
    };
  };
}
