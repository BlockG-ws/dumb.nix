{
  description = "Dumb NixOS - A comprehensive live ISO with hardware testing and system maintenance tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }: 
   let
    pkgsWithConfig = system: nixpkgs.legacyPackages.${system}.extend (final: prev: {
      clonezilla = final.callPackage ./pkgs/clonezilla.nix { };
    });
  in
  {
    nixosConfigurations = {
      iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          pkgs = pkgsWithConfig "x86_64-linux";
        };
        modules = [
          {
            nixpkgs.config.allowUnfree = true;
          }
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
