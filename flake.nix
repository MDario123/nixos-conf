{
  description = "Home Manager configuration of mdario";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs :
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in {
      devShells.${system}.default = pkgs.clangStdenv.mkDerivation {
        name = "shell";
        nativeBuildInputs = with pkgs; [
          rnix-lsp
        ];
        shellHook = "nvim";
      };
 
      nixosConfigurations = {
        mdario = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit system inputs outputs; };
          modules = [
            ./nixos/configuration.nix
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
