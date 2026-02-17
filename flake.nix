{
  description = "Dumb NixOS - A comprehensive live ISO with hardware testing and system maintenance tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }: 
   let
     system = "x86_64-linux";
     pkgsWithConfig = nixpkgs.legacyPackages.${system}.extend (final: prev: {
       clonezilla = final.callPackage ./pkgs/clonezilla.nix { };
     });
   in
   {
     nixosConfigurations = {
       iso = nixpkgs.lib.nixosSystem {
         inherit system;
         pkgs = pkgsWithConfig;
         modules = [
           {
             nixpkgs = {
               inherit pkgs;
               config.allowUnfree = true;
               config.allowBroken = false;
             };
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
