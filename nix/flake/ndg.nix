{
  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        darkhttpd
        ndg
        watchexec
      ];
    };
  };
}
