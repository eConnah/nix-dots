{ inputs, ... }:
{
  imports = [ inputs.flake-file.flakeModules.dendritic ];

  systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];

}
