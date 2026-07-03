{ inputs, ... }:
{
  systems = [
    "aarch64-linux"
    "x86_64-linux"
    "aarch64-darwin"
  ];

  perSystem =
    { pkgs, ... }:
    {
      formatter = pkgs.nixfmt;
    };
}
