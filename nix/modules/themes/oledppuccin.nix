{ self, ... }: {
  flake =
    let
      oledppuccin = self + "/not-nix/themes/oledppuccin/";
    in
    {
      hjemModules.oledppuccin = {
        rum.programs.fish.config = ''
          fish_config theme choose oledppuccin
        '';
        rum.programs.kitty.settings.include = "oledppuccin.conf";
        xdg.config.files = {
          "bat/config".text = "--theme='oledppuccin'";
          "bat/themes/oledppuccin.tmTheme".source = oledppuccin + "bat.tmTheme";
          "eza/theme.yml".source = oledppuccin + "eza.yml";
          "fish/themes/oledppuccin.theme".source = oledppuccin + "fish.theme";
          "kitty/diff.conf".source = oledppuccin + "kitty/diff.conf";
          "kitty/oledppuccin.conf".source = oledppuccin + "kitty/oledppuccin.conf";
        };
      };
      nixosModules.oledppuccin = {
        boot = {
          kernelParams = [
            "vt.default_red=0,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166"
            "vt.default_grn=0,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173"
            "vt.default_blu=0,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200"
          ];
          loader.limine = {
            extraConfig = builtins.readFile (oledppuccin + "limine.conf");
            style.interface.branding = "";
          };
        };
      };
    };
}
