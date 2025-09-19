{ config, pkgs, ... }:

{
        environment.systemPackages = with pkgs; [
        qq
	feishu
	telegram-desktop
        ];
}

