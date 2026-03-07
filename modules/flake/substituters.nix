{ inputs, ... }:
{
  flake.nixosModules.substituters = {
    nix.settings = {
      extra-substituters = [
        "https://vicinae.cachix.org"
        "https://nixos-apple-silicon.cachix.org"
      ];
      extra-trusted-public-keys = [
        "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
        "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
      ];
    };
  };
}
