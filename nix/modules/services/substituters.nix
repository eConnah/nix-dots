{inputs, ...}: {
  flake.nixosModules.substituters = {lib, ...}: {
    imports = [inputs.ncro.nixosModules.default];
    services.ncro = {
      enable = true;
      port = 49152;
      settings = {
        fallback_cache = {
          enabled = true;
          url = "https://cache.nixos.org";
          public_key = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
        };
        upstreams = [
          {
            url = "https://cache.nixos.org";
            priority = 10;
            public_key = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
          }
          {
            url = "https://nix-community.cachix.org";
            priority = 20;
            public_key = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
          }
          {
            url = "https://cache.nixos-cuda.org";
            priority = 30;
            public_key = "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=";
          }
          {
            url = "https://nixos-apple-silicon.cachix.org";
            priority = 40;
            public_key = "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20=";
          }
          {
            url = "https://nix-secrets.cachix.org";
            priority = 50;
            public_key = "nix-secrets.cachix.org-1:NSwybk1LexO4kPH755itLM1t2NGegVq9YR22KlG8Vp0=";
          }
          {
            url = "https://afnix-hydra.s3-bulk-web.afnix.fr/";
            priority = 60;
            public_key = "afnix:oqt801y+IwJ09XRtNDQYCKb7zuCw9DQXQk8fDWPkwxM=";
          }
        ];
        logging.timestamps = false;
      };
    };

    # force Nix to exclusively route everything through ncro
    nix.settings.substituters = lib.mkForce ["http://localhost:49152"];
    system.nixos-core.persistence.stores."/persistent".directories = ["/var/lib/private/ncro"];
  };
}
