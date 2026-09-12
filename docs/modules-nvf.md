+++
title = "Nix-Dots - NVF Modules"
+++

<link rel="icon" type="image/svg+xml" href="assets/nix.svg">

# NVF Modules

## defaults

The core Neovim configuration. Defines 4-space tab indentation, enables
`blink-cmp` for completion, configures clipboard providers, and installs
language support (Nix, Rust, Lua, Python, etc.) with LSP formatting. Integrates
the `catppuccin` theme and cursor smear plugins.

## notes

Enables the `todo-comments` plugin for tracking project tasks and
`ui.illuminate` for highlighting word usages.

## ui

Enhances the Neovim interface by enabling `nvim-notify`, floating window
borders, colour code highlighting (`colorizer`), and the `noice` UI replacement.

## workflow

Configures editor workflow tools, enabling `harpoon` for navigation, floating
terminal support via `toggleterm` (with `lazygit` integration), `oil-nvim` for
file editing, and text `surround` utilities.

## Usage

These modules are not applied directly to a host. They are composed into a
single Neovim package, `nvim-qwerty`, via `inputs.nvf.lib.neovimConfiguration`
in a `perSystem` output. Any host that wants this editor adds
`self'.packages.nvim-qwerty` to its `environment.systemPackages`, as most
