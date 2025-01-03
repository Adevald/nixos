{ config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases= {
      v     = "nvim";
      hms   = "home-manager switch --flake ~/nix";
      rb    = "nixos-rebuild switch --flake /root/nix";
      ff    = "fastfetch";
      nixv  = "nvim ~/nix"; # fast open nvim in nix config folder
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" "sudo" ];
      theme = "agnoster";
    };
  };
}
