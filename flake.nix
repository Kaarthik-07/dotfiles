{
  description = "abishek's system config";

  inputs = {
    nixpkgs.url      = "github:nixos/nixpkgs/nixos-unstable";
    home-manager     = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    nix-darwin       = { url = "github:lnl7/nix-darwin";            inputs.nixpkgs.follows = "nixpkgs"; };
    nixos-wsl        = { url = "github:nix-community/NixOS-WSL";    inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = { nixpkgs, home-manager, nix-darwin, nixos-wsl, ... }@inputs:
  let
    hmModule = user: file: {
      home-manager.useGlobalPkgs    = true;
      home-manager.useUserPackages  = true;
      home-manager.users.${user}    = import file;
    };
  in {

    # -- macOS ----------------------------------------------------------------
    darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem {
      system      = "aarch64-darwin";
      specialArgs = { inherit inputs; };
      modules     = [
        ./hosts/macbook/default.nix
        home-manager.darwinModules.home-manager
        (hmModule "mikey" ./hosts/macbook/home.nix)
      ];
    };

    # -- Linux ----------------------------------------------------------------
    nixosConfigurations."linux" = nixpkgs.lib.nixosSystem {
      system      = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules     = [
        ./hosts/linux/default.nix
        home-manager.nixosModules.home-manager
        (hmModule "mikey" ./hosts/linux/home.nix)
      ];
    };

    # -- WSL ------------------------------------------------------------------
    nixosConfigurations."wsl" = nixpkgs.lib.nixosSystem {
      system      = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules     = [
        nixos-wsl.nixosModules.wsl
        ./hosts/wsl/default.nix
        home-manager.nixosModules.home-manager
        (hmModule "mikey" ./hosts/wsl/home.nix)
      ];
    };

  };
}
