{
  description = "Home Manager configuration of mdario";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nur.url = "github:nix-community/NUR";
    isw-nix = {
      url = "github:iannisimo/isw-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, ... } @ inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {
        mdario = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit system inputs outputs; };
          modules = [
            inputs.isw-nix.nixosModule
            ./nixos/configuration.nix
            ./nixos/hardware/msi.nix
            ./nixos/hardware/nvidia.nix
          ];
        };
      };

      homeConfigurations."mdario" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = { inherit inputs outputs; };
        modules = [ ./home-manager/home.nix ];
      };
    };
}
