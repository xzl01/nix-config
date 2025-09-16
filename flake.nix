{
  description = "整合版NixOS Flakes配置";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    hydenix.url = "github:richen604/hydenix";
    nix-index.url = "github:nix-community/nix-index-database";
    
    # 依赖关系声明
    hydenix.inputs.nixpkgs.follows = "nixpkgs";
    nix-index.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, hydenix, nix-index, ... }@inputs: {
    nixosConfigurations.nixos-xzl = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # 基础配置
        ./configuration.nix
        
        # Hydenix核心模块
        inputs.hydenix.inputs.hydenix-nixpkgs.lib.modules.common
        
        # 系统增强
        {
          # 包管理优化
          nixpkgs.overlays = [ inputs.nix-index.overlays.default ];
          
          # 环境配置
          environment.systemPackages = [ pkgs.chromium ];
          programs.zsh.enable = true;
        }
      ];
    };
  };
}
