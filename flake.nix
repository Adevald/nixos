{
  description = "Brain of Holding flake conf";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs = {nixpkgs, nixpkgs-stable, nixvim, home-manager, ...}@inputs: 
    let 
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
    in {

      # NIX CONFS
      nixosConfigurations.lenovo-laptop = nixpkgs.lib.nixosSystem {
	specialArgs = {
          #pkgs-stable = import nixpkgs-stable {
	  #  inherit system;
          #  config.allowUnfree = true;
          #};
          inherit inputs;
        };

        modules = [
          ./nix-cfg/lenovo-laptop-configuration.nix
          nixvim.nixosModules.nixvim
          home-manager.nixosModules.default
          #home-manager.nixosModules.home-manager {
          #  home-manager.useGlobalPkgs = true;
          #  home-manager.useUserPackages = true;
          #  home-manager.users.adevald = import ./home-manager/user-adevald/home.nix;
          #}
        ];
      };


      # HOME CONFS
      homeConfigurations.root = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home-manager/user-root/home.nix
          nixvim.homeManagerModules.nixvim
        ];

        extraSpecialArgs = { inherit inputs; };
      };

      homeConfigurations.adevald = home-manager.lib.homeManagerConfiguration { 
        inherit pkgs;
        modules = [ 
          ./home-manager/user-adevald/home.nix
          nixvim.homeManagerModules.nixvim
        ];
        extraSpecialArgs = { inherit inputs; };
      };
  };
}
