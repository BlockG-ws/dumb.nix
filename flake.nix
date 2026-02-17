{
  description = "Dumb NixOS - A comprehensive live ISO with hardware testing and system maintenance tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }: 
   let
     system = "x86_64-linux";
   in
   {
     nixosConfigurations = {
       iso = nixpkgs.lib.nixosSystem {
         inherit system;
         modules = [
           {
             nixpkgs = {
               config.allowUnfree = true;
               overlays = [
                 (final: prev: {
                   clonezilla = final.callPackage ./pkgs/clonezilla.nix { };
                 })
               ];
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
