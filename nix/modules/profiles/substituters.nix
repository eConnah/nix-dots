{
  flake.nixosModules.substituters = {
    nix.settings = {
      substituters = [
        "https://vicinae.cachix.org"
        "https://nixos-apple-silicon.cachix.org"
        "https://afnix-hydra.s3-bulk-web.afnix.fr/"
      ];
      trusted-public-keys = [
        "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
        "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
        "afnix:oqt801y+IwJ09XRtNDQYCKb7zuCw9DQXQk8fDWPkwxM="
      ];
    };
  };
}
