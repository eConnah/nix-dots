# A module to enable the asahi kernel and necessary settings

{ config, pkgs, lib, inputs, ... }:

with lib;

let
  cfg = config.hardware.asahi;
in
{
  imports = [ inputs.apple-silicon.nixosModules.apple-silicon-support ];

  options.hardware.asahi = {
    extraModprobeConfig = mkOption {
      type = types.lines;
      default = ''
        options hid_apple iso_layout=0
      '';
      description = "Extra modprobe configuration for Apple Silicon hardware";
    };

    limine = {
      extraConfig = mkOption {
        type = types.lines;
        default = ''
          term_palette: 1e1e2e;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
          term_palette_bright: 585b70;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
          term_background: 1e1e2e
          term_foreground: cdd6f4
          term_background_bright: 585b70
          term_foreground_bright: cdd6f4
        '';
        description = "Extra Limine bootloader configuration";
      };

      wallpapers = mkOption {
        type = types.listOf types.path;
        default = [ ];
        description = "Limine bootloader wallpapers";
      };
    };
  };

  config = {
    nixpkgs.config.allowUnsupportedSystem = true;
    
    boot.loader.efi.canTouchEfiVariables = false;
    
    boot.extraModprobeConfig = cfg.extraModprobeConfig;
    
    boot.loader.limine = {
      enable = true;
      extraConfig = cfg.limine.extraConfig;
      style.wallpapers = cfg.limine.wallpapers;
    };

    virtualisation = {
      # Docker stuff
      docker = {
        enable = false;
        storageDriver = "btrfs";
        rootless = {
          enable = true;
          setSocketVariable = true;
          # Optionally customize rootless Docker daemon settings
          daemon.settings = {
            registry-mirrors = [ "https://mirror.gcr.io" ];
          };
        };
      };
      # Podman stuff
      podman = {
        enable = true;
        dockerCompat = true;
      };
    };
  };
}
