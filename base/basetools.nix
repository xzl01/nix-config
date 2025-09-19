{ config, pkgs, ... }:

{
        environment.systemPackages = with pkgs; [
        usbutils
	pciutils
	alsa-firmware
	alsa-oss
	alsa-lib
	alsa-utils
	alsa-tools
	alsa-plugins
	libfprint
	fprintd
        ];
}

