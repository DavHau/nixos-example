{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
  in
  {

    nixosConfigurations = {
      v-machine = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/v-machine/configuration.nix
        ];
      };
    };

    packages.${system} = {
      v-iso = self.nixosConfigurations.v-machine.config.system.build.images.iso;
      v-img = self.nixosConfigurations.v-machine.config.system.build.images.raw;
      v-vm = self.nixosConfigurations.v-machine.config.system.build.vm;
    };

  };
}
