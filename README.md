# Example NixOS config

## How to read this code

The entry point is the `flake.nix` file.
Everything else is imported from there
All buildable outputs are defined at the bottom of the `flake.nix`

If you add new files to this repo, you must add them to git before executing `nix build`. Nix ignores untracked files and will crash with a file not found error.

## Usage

### Setup

#### 1. Install nix

Use your distro's native package manager to install nix or use the official nix installer https://nixos.org/download/

#### 2. Enable flakes (required for this repo)

Add the following to ~/.config/nix/nix.conf or /etc/nix/nix.conf:
```
experimental-features = nix-command flakes
```

### Build Artifacts

#### build ISO image (live system for USB drive)
```
nix build .#v-iso
```
#### build mutable image (like the iso, but can update itself)
This is recommended, as it allows switching to a new configuration via `nixos-rebuild switch --flake .` without having to re-flash the iso every time.
```
nix build .#v-img
```
#### build vm (runs config in a qemu VM locally)
```
nix build .#v-vm
./result/bin/run-nixos-vm
```

### Switching the current system
On any nixos system with read-write disk (eg. a booted `v-img` from above), simply clone this repo, then execute:
```
nixos-rebuild --flake .#v-machine switch
```
... which switches the current system in place to the new one defined by the config.

If the evaluation fails because of missing filesystems definition, generate a hardware config first using:
```
nixos-generate-config --show-hardware-config > hardware-configuration.nix
```
Then add that file to your repo and import it in your configuration.nix.
Don't forget to add the new `hardware-configuration.nix` to git.
