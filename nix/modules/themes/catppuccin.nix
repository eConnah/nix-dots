{ inputs, self, ... }:
{
  flake.nixosModules.catppuccin =
    {
      pkgs,
      config,
      lib,
      home-manager,
      ...
    }:
    {
      boot.loader.limine = lib.mkIf config.boot.loader.limine.enable {
        extraConfig = ''
          term_palette: 1e1e2e;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
          term_palette_bright: 585b70;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
          term_background: 1e1e2e
          term_foreground: cdd6f4
          term_background_bright: 585b70
          term_foreground_bright: cdd6f4
        '';

        style.wallpapers = [ ];
      };

      home-manager.sharedModules = [
        self.homeModules.catppuccin
      ];
    };

  flake.homeModules.catppuccin =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      programs.eza.theme = lib.mkIf config.programs.eza.enable (
        builtins.fromJSON ''
          {
            "colourful": true,
            "filekinds": {
              "normal": { "foreground": "#cdd6f4" },
              "directory": { "foreground": "#cba6f7" },
              "symlink": { "foreground": "#89b4fa" },
              "pipe": { "foreground": "#bac2de" },
              "block_device": { "foreground": "#eba0ac" },
              "char_device": { "foreground": "#eba0ac" },
              "socket": { "foreground": "#bac2de" },
              "special": { "foreground": "#cba6f7" },
              "executable": { "foreground": "#a6e3a1" },
              "mount_point": { "foreground": "#94e2d5" }
            },
            "perms": {
              "user_read": { "foreground": "#f38ba8", "is_bold": true },
              "user_write": { "foreground": "#f9e2af", "is_bold": true },
              "user_execute_file": { "foreground": "#a6e3a1", "is_bold": true },
              "user_execute_other": { "foreground": "#a6e3a1", "is_bold": true },
              "group_read": { "foreground": "#f38ba8" },
              "group_write": { "foreground": "#f9e2af" },
              "group_execute": { "foreground": "#a6e3a1" },
              "other_read": { "foreground": "#f38ba8" },
              "other_write": { "foreground": "#f9e2af" },
              "other_execute": { "foreground": "#a6e3a1" },
              "special_user_file": { "foreground": "#cba6f7" },
              "special_other": { "foreground": "#7f849c" },
              "attribute": { "foreground": "#9399b2" }
            },
            "size": {
              "major": { "foreground": "#a6adc8" },
              "minor": { "foreground": "#89dceb" },
              "number_byte": { "foreground": "#bac2de" },
              "number_kilo": { "foreground": "#a6adc8" },
              "number_mega": { "foreground": "#89b4fa" },
              "number_giga": { "foreground": "#cba6f7" },
              "number_huge": { "foreground": "#cba6f7" },
              "unit_byte": { "foreground": "#a6adc8" },
              "unit_kilo": { "foreground": "#89dceb" },
              "unit_mega": { "foreground": "#cba6f7" },
              "unit_giga": { "foreground": "#cba6f7" },
              "unit_huge": { "foreground": "#94e2d5" }
            },
            "users": {
              "user_you": { "foreground": "#cdd6f4" },
              "user_root": { "foreground": "#f38ba8" },
              "user_other": { "foreground": "#eba0ac" },
              "group_yours": { "foreground": "#a6adc8" },
              "group_other": { "foreground": "#9399b2" },
              "group_root": { "foreground": "#f38ba8" }
            },
            "links": {
              "normal": { "foreground": "#89b4fa" },
              "multi_link_file": { "foreground": "#89b4fa" }
            },
            "git": {
              "new": { "foreground": "#a6e3a1" },
              "modified": { "foreground": "#f9e2af" },
              "deleted": { "foreground": "#eba0ac" },
              "renamed": { "foreground": "#94e2d5" },
              "typechange": { "foreground": "#f5c2e7" },
              "ignored": { "foreground": "#7f849c" },
              "conflicted": { "foreground": "#fab387" }
            },
            "git_repo": {
              "branch_main": { "foreground": "#a6adc8" },
              "branch_other": { "foreground": "#cba6f7" },
              "git_clean": { "foreground": "#a6e3a1" },
              "git_dirty": { "foreground": "#eba0ac" }
            },
            "security_context": {
              "colon": { "foreground": "#6c7086" },
              "user": { "foreground": "#7f849c" },
              "role": { "foreground": "#cba6f7" },
              "typ": { "foreground": "#585b70" },
              "range": { "foreground": "#cba6f7" }
            },
            "file_type": {
              "image": { "foreground": "#f9e2af" },
              "video": { "foreground": "#f38ba8" },
              "music": { "foreground": "#a6e3a1" },
              "lossless": { "foreground": "#94e2d5" },
              "crypto": { "foreground": "#7f849c" },
              "document": { "foreground": "#cdd6f4" },
              "compressed": { "foreground": "#f5c2e7" },
              "temp": { "foreground": "#eba0ac" },
              "compiled": { "foreground": "#74c7ec" },
              "source": { "foreground": "#89b4fa" }
            },
            "punctuation": { "foreground": "#6c7086" },
            "date": { "foreground": "#f9e2af" },
            "inode": { "foreground": "#a6adc8" },
            "blocks": { "foreground": "#6c7086" },
            "header": { "foreground": "#cdd6f4" },
            "octal": { "foreground": "#94e2d5" },
            "flags": { "foreground": "#cba6f7" },
            "symlink_path": { "foreground": "#89dceb" },
            "control_char": { "foreground": "#74c7ec" },
            "broken_symlink": { "foreground": "#f38ba8" },
            "broken_path_overlay": { "foreground": "#585b70" }
          }''
      );

      home.file.".config/fish/themes/catppuccin-mocha.theme" = lib.mkIf config.programs.fish.enable {
        text = ''
          # name: 'Catppuccin Mocha'
          # url: 'https://github.com/catppuccin/fish'
          # preferred_background: 1e1e2e

          fish_color_normal cdd6f4
          fish_color_command 89b4fa
          fish_color_param f2cdcd
          fish_color_keyword f38ba8
          fish_color_quote a6e3a1
          fish_color_redirection f5c2e7
          fish_color_end fab387
          fish_color_comment 7f849c
          fish_color_error f38ba8
          fish_color_gray 6c7086
          fish_color_selection --background=313244
          fish_color_search_match --background=313244
          fish_color_option a6e3a1
          fish_color_operator f5c2e7
          fish_color_escape eba0ac
          fish_color_autosuggestion 6c7086
          fish_color_cancel f38ba8
          fish_color_cwd f9e2af
          fish_color_user 94e2d5
          fish_color_host 89b4fa
          fish_color_host_remote a6e3a1
          fish_color_status f38ba8
          fish_pager_color_progress 6c7086
          fish_pager_color_prefix f5c2e7
          fish_pager_color_completion cdd6f4
          fish_pager_color_description 6c7086
        '';
      };
    };
}
