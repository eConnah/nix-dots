{
  flake.nixosModules.substituters = {
    nix.settings = {
      substituters = [
        "https://afnix-hydra.s3-bulk-web.afnix.fr/"
        "https://nix-secrets.cachix.org"
        "https://nixos-apple-silicon.cachix.org"
      ];
      trusted-public-keys = [
        "afnix:oqt801y+IwJ09XRtNDQYCKb7zuCw9DQXQk8fDWPkwxM="
        "nix-secrets.cachix.org-1:NSwybk1LexO4kPH755itLM1t2NGegVq9YR22KlG8Vp0="
        "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
      ];
    };
  };
}
