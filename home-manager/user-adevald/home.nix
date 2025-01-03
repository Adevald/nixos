{
  imports = [
    #  ../modules/basic.nix
    ../modules/full-bundle.nix
    ../modules/window-managers/hyprland/hyprland.nix
  ];

  home = {
    username = "adevald";
    homeDirectory = "/home/adevald";
    stateVersion = "24.05";
  };

  

  # User soft
  programs.git = {
    userName = "adevald";
    userEmail = "adeeee6622@gmail.com";
  };
}
