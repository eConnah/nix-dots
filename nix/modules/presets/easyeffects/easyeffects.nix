{ inputs, self, ... }:
{
  flake.homeModules.easyeffects =
    { config, lib, ... }:
    {
      # 1. Change the option to accept a LIST of strings
      options.theme.audioPresets = lib.mkOption {
        default = [ ];
        description = "List of EasyEffects preset filenames to install.";
        type = lib.types.listOf lib.types.str;
      };
      # 2. Loop through the list and generate a file for each one
      config = lib.mkMerge (
        map (presetName: {
          home.file.".config/easyeffects/input/${presetName}".source = ./easyeffects/${presetName};
        }) config.theme.audioPresets
      );
    };
}
