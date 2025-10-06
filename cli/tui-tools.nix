{config,  pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    btop
    htop
    fastfetch
    less
    ncdu
  ];
}
