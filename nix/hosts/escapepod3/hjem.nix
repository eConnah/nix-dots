{self, ...}: {
  flake.nixosModules.escapepod3-hjem = {pkgs, ...}: {
    hjem = {
      users.leo = {
        imports = with self.hjemModules; [
          escapepod3-hyprland
          asahi
        ];
        packages = with pkgs; [
          (plezy.override {use16kPagesizeWorkaround = true;})
        ];
        theme.wallpaper = "ultrakill-01.png";
      };
    };
  };
}
