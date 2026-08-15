{ inputs, ... }: {
  flake = {
    nixosModules.catppuccin =
      {
        lib,
        pkgs,
        ...
      }:
      let
        oled = {
          mocha = {
            base = "000000";
            crust = "020202";
            mantle = "010101";
          };
        };
      in
      {
        imports = [ inputs.catppuccin.nixosModules.catppuccin ];
        catppuccin = {
          enable = true;
          accent = "mauve";
          autoEnable = true;
          flavor = "mocha";
          sources = inputs.catppuccin.packages.${pkgs.stdenv.hostPlatform.system}.overrideScope (
            final: prev: {
              palette =
                pkgs.runCommand "catppuccin-palette-oled"
                  {
                    nativeBuildInputs = [ pkgs.jq ];
                  }
                  ''
                    mkdir -p $out
                    jq '
                      .mocha.colors.base.hex   = "#000000" |
                      .mocha.colors.mantle.hex = "#010101" |
                      .mocha.colors.crust.hex  = "#020202"
                    ' ${prev.palette}/palette.json > $out/palette.json
                  '';
              whiskers = pkgs.symlinkJoin {
                name = "whiskers-wrapped";
                nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
                paths = [ prev.whiskers ];
                postBuild = ''
                  wrapProgram $out/bin/whiskers \
                    --add-flag ${lib.escapeShellArg "--color-overrides=${builtins.toJSON oled}"}
                '';
                meta.mainProgram = "whiskers";
              };
            }
          );
        };
      };
  };
}
