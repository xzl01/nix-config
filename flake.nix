{
  description = "xzl-nixos-config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-patched.url = "github:cryolitia/nixpkgs/nixos-unstable";
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

  outputs = { self, nixpkgs, nur, ... }@inputs:
    let
      system = "x86_64-linux";

      # ✅ 关键：将 nur.overlay 加入 overlays
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [ nur.overlay ];  # ←←← 这一行是修复的关键
      };
    in {
      nixosConfigurations.nixos-xzl = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit pkgs; };  # 可选但推荐：把 pkgs 传给模块

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
