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
				blueman
				bluez
				sing-box
        ];
	services.fprintd.enable = true;
	services.fprintd.tod.enable = true;
	services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;
	services.blueman.enable = true;
	services.sing-box.enable = true;
	

}
