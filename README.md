# NixOS System Configurations

This repository contains my declarative NixOS and Home Manager configurations. It is structured using a dendritic architecture, which strictly separates hardware-agnostic defaults and user profiles from host-specific hardware configurations. 

## Repository Structure

The configuration uses `import-tree` to automatically evaluate modules within the `nix/` directory.

* `flake.nix`: The primary entry point defining inputs (nixpkgs, disko, preservation, home-manager, etc.) and outputs.
* `nix/hosts/`: Machine-specific configurations.
    * `onyx`: Desktop PC configuration.
    * `lenix`: Apple Silicon laptop configuration.
    * `iso`: Minimal Live USB configuration for bootstrapping.
* `nix/modules/`: Reusable components and logic.
    * `profiles/`: Shared system configurations, package sets, and specific hardware logic (e.g., Asahi, Nvidia).
    * `programs/`: Application-specific settings (e.g., Neovim, Vicinae).
    * `desktops/`: Window manager configurations (Hyprland).
    * `users/`: User-specific data and Home Manager integrations.

## Host Configurations

### Onyx (Desktop)
A desktop environment configured for gaming and general use.
* **Filesystem:** Declarative Btrfs disk layout managed by Disko.
* **State Management:** Ephemeral root on tmpfs (`/`), with opt-in state persistence managed by Preservation. System and user data are routed to a persistent NVMe subvolume.
* **Hardware:** Nvidia proprietary drivers with modesetting.
* **Networking:** Minimal `dhcpcd` configuration, with Tailscale for secure network access.

### Lenix (Laptop)
A laptop configuration tailored for Apple Silicon hardware.
* **Hardware Integration:** Utilises the `apple-silicon-support` flake.
* **Power Management:** Specific configurations and scripts designed for the Asahi Linux environment, isolated to prevent path conflicts on standard x86 hardware.

### ISO
A lightweight, hardware-agnostic Live USB configuration. It imports basic terminal profiles (Neovim, Fish shell, SSH keys) to provide a familiar environment for formatting disks and bootstrapping systems, without compiling graphical environments or proprietary drivers.

## Key Technologies

* **NixOS & Flakes:** System configuration and dependency management.
* **Home Manager:** User environment and dotfile management.
* **Disko:** Declarative disk partitioning and formatting.
* **Preservation:** Opt-in state management for ephemeral root filesystems.
* **Hyprland:** Wayland compositor.
* **Catppuccin:** System-wide colour theme integration.

## Usage

To bootstrap a new machine, build the minimal ISO image:

```bash
nix build .#nixosConfigurations.iso.config.system.build.isoImage