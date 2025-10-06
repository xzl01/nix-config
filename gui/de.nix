{config,  pkgs, nur, ...}:

{
  environment.systemPackages = with pkgs; [
    niri
    quickshell
    wofi
    wl-clipboard
    grim
    nur.repos.guoard.hiddify
  ];
  programs.niri.enable=true;
}
