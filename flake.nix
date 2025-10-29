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

  outputs = { self, nixpkgs, nur, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [ nur.overlay ];
      };
    in {
      nixosConfigurations.nixos-xzl = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit pkgs; };  # 可选：传给你的模块
        modules = [
          # ✅ 正确方式：使用 readOnlyPkgs 模块并设置 pkgs
          {
            imports = [ (nixpkgs + "/nixos/modules/misc/nixpkgs/read-only.nix") ];
            nixpkgs.pkgs = pkgs;
            # 注意：不要设置 nixpkgs.system，它是无效的
          }

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
