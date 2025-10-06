{
  description = "xzl-nixos-config";

  inputs = {
    # NixOS 官方软件源，这里使用 nixos-unstable 分支
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-patched.url = "github:cryolitia/nixpkgs/nixos-unstable";

    # home-manager，用于管理用户配置
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs,nur,home-manager, ... }@inputs: {
    nixosConfigurations.nixos-xzl = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
	./base/fonts.nix
        ./base/basetools.nix
        ./cli/tui-tools.nix
        ./gui/fcitx5.nix
        ./gui/devtools.nix
        ./gui/im.nix
        ./gui/de.nix
      ];
    };
  };
}
