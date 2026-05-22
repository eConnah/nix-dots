# NixOS System Configurations

This repository contains my declarative NixOS and Home Manager configurations. It is structured using a dendritic architecture, which strictly separates hardware-agnostic defaults and user profiles from host-specific hardware configurations.

## Repository Structure

The configuration uses `import-tree` to automatically evaluate modules within the `nix/` directory.

* `flake.nix`: The primary entry point defining inputs (nixpkgs, disko, preservation, home-manager, etc.) and outputs.
* `nix/hosts/`: Machine-specific configurations.
    * `onyx`: Connor's PC configuration.
    * `lenix`: Connor's Apple Silicon laptop configuration.
    * `escapepod3`: Leo's Apple Silicon laptop configuration.
* `nix/modules/`: Reusable components and logic.
    * `profiles/`: Shared system configurations, package sets, and specific hardware logic (e.g., Asahi, Nvidia).
    * `programs/`: Application-specific settings (e.g., Neovim, Vicinae, Hyprpanel).
    * `desktops/`: Window manager configurations (Hyprland).
    * `services/`: User service configurations (e.g., swaybg).
    * `themes/`: System-wide colour theme integrations (Catppuccin).
    * `presets/`: Non-nix mass presets.
    * `users/`: User-specific data and Home Manager integrations.

## Host Configurations

### Onyx (Desktop)
Connor's desktop environment configured for gaming and general use.
* **Filesystem:** Declarative Btrfs disk layout managed by Disko.
* **State Management:** Ephemeral root on tmpfs (`/`), with opt-in persistence managed by Preservation. System and user data are routed to a persistent NVMe subvolume.
* **Hardware:** Nvidia proprietary drivers with modesetting.
* **Networking:** Minimal systemd-networkd configuration, with Tailscale for secure network access.

### Lenix (Laptop)
Connor's laptop configuration tailored for Apple Silicon hardware.
* **Hardware Integration:** Utilises the `apple-silicon-support` flake.
* **Memory:** zswap with lz4 compression and x86 emulation via binfmt.
* **Power Management:** iio-hyprland for auto-rotation, but Asahi suspend unsupported.

### Escapepod3 (Laptop)
Leo's laptop configuration, also targeting Apple Silicon hardware.
* **Hardware Integration:** Utilises the `apple-silicon-support` flake, sharing the Asahi profile with Lenix.
* **Memory:** zswap with lz4 compression and x86 emulation via binfmt.
* **Power Management:** iio-hyprland for auto-rotation, but Asahi suspend unsupported.

## Key Technologies

* **NixOS & Flakes:** System configuration and dependency management.
* **Home Manager:** User environment and dotfile management.
* **Disko:** Declarative disk partitioning and formatting.
* **Preservation:** Opt-in state management for ephemeral root filesystems.
* **Hyprland:** Wayland compositor managed via UWSM.
* **Catppuccin:** System-wide colour theme integration.
* **Vicinae:** Application launcher.
