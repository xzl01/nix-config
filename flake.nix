{
  description = "xzl的nix配置 with hydenix";
  
  inputs = {
    # 基础系统依赖
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    
    # Hydenix扩展
    hydenix = {
      url = "github:richen604/hydenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # 系统工具依赖
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, hydenix, nix-index-database, ... }@inputs: {
    # 基础系统配置
    nixosConfigurations.nixos-xzl = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # 基础配置
        ./configuration.nix
        
        # Hydenix核心模块
        inputs.hydenix.inputs.hydenix-nixpkgs.lib.modules.common
        
        # 系统工具配置
        {
          nixpkgs.overlays = [ inputs.nix-index-database.overlays.default ];
        }
      ];
    };

    # 增强开发配置
    nixosConfigurations.developer = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # 用户基础配置
        ./configuration
