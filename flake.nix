{
  description = "xzl-nixos-config";

  inputs = {
    # NixOS 官方软件源，这里使用 nixos-25.05 分支
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos-xzl = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
	./base/fonts.nix
	./gui/fcitx5.nix
      ];
    };
  };
}
