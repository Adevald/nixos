{ pkgs, ...}: {
  imports = [
    #  ../modules/basic.nix
    ../modules/full-bundle.nix
    ../modules/window-managers/hyprland/hyprland.nix
  ];

  home = {
    username = "root";
    homeDirectory = "/root";
    stateVersion = "24.11";
  };

  # User soft
  programs.git = {
    enable = true;
    userName = "adevald";
    userEmail = "adeeee6622@gmail.com";
  };
}
