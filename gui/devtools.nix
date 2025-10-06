{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
	vscode
	kdiff3
	];
}
