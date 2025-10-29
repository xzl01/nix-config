{config,  pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    niri
    quickshell
    wofi
    wl-clipboard
    grim
    clash-verge-rev
    nur.repos.guoard.hiddify
  ];
  programs.niri.enable=true;
  programs.clash-verge.enable = true;
}
