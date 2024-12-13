{
  description = "Home Manager configuration of mdario";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    isw-nix = {
      url = "github:iannisimo/isw-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
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
            # inputs.isw-nix.nixosModule
            {
              imports = [ aagl.nixosModules.default ];
              nix.settings = aagl.nixConfig; # Set up Cachix
              programs.anime-game-launcher.enable = true;
            }
            ./nixos/hardware/hp
            ./nixos/configuration.nix
            ./nixos/displayManager/gdm.nix
            ./nixos/desktops/hyprland.nix
            ./nixos/desktops/gnome.nix
            ./nixos/activities/programming.nix
            ./nixos/activities/docker.nix
            ./nixos/activities/gaming.nix
            ./nixos/activities/music.nix
          ];
        };
      };

      homeConfigurations."mdario" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = { inherit inputs outputs; };
        modules = [
          ./home-manager/home.nix
          ./home-manager/terminal
          ./home-manager/graphical
        ];
      };

      homeConfigurations."server" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = { inherit inputs outputs; };
        modules = [
          ./home-manager/home.nix
          ./home-manager/terminal
        ];
      };
    };
}
