{
  description = "Home Manager configuration of dk";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      nixpkgs-stable,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgsStable = nixpkgs-stable.legacyPackages.${system};
    in
    {
      homeConfigurations."dk" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
          nixvim.homeModules.nixvim
        ];

        # Optionally use extraSpecialArgs
        extraSpecialArgs = {
          pkgs-stable = pkgsStable;
        };
      };
    };
}
