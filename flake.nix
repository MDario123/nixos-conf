{
  description = "Home Manager configuration of mdario";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, aagl, ... } @ inputs:
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
            {
              imports = [ aagl.nixosModules.default ];
              nix.settings = aagl.nixConfig; # Set up Cachix
              programs.anime-game-launcher.enable = true;
              # programs.anime-games-launcher.enable = true;
              # programs.anime-borb-launcher.enable = true;
              # programs.honkers-railway-launcher.enable = true;
              # programs.honkers-launcher.enable = true;
            }
            ./nixos/configuration.nix
            ./nixos/desktops/hyprland.nix
            ./nixos/programming.nix
            ./nixos/gaming.nix
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
