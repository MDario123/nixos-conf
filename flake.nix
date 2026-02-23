{
  description = "Home Manager configuration of mdario";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
    mbas = {
      url = "github:MDario123/mbas";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      aagl,
      mbas,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      unstable-pkgs = import nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {
        mdario = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit
              system
              inputs
              outputs
              unstable-pkgs
              ;
          };
          modules = [
            # inputs.isw-nix.nixosModule
            {
              environment.systemPackages = [
                (mbas.packages.${system}.mbas.override { NIX_ENFORCE_NO_NATIVE=false; build="RELEASE_NATIVE"; })
              ];
            }
            ./nixos/hardware/hp
            ./nixos/configuration.nix
            ./nixos/displayManager/greetd.nix
            ./nixos/desktops/hyprland.nix
            ./nixos/activities/common.nix
            ./nixos/activities/communication.nix
            ./nixos/activities/programming.nix
            ./nixos/activities/docker.nix
            ./nixos/activities/gaming.nix
            ./nixos/activities/music.nix
            ./nixos/activities/productivity.nix
          ];
        };
      };

      homeConfigurations."mdario" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = { inherit inputs outputs; };
        modules = [
          ./home-manager/home.nix
          ./home-manager/mpd.nix
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
