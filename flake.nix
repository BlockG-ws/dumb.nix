{
  description = "Dumb NixOS - A comprehensive live ISO with hardware testing and system maintenance tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./iso.nix
        ];
      };
    };

    # 方便构建的输出
    packages.x86_64-linux = {
      default = self.nixosConfigurations.iso.config.system.build.isoImage;
      iso = self.nixosConfigurations.iso.config.system.build.isoImage;
    };
  };
}
