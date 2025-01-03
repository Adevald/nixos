{ pkgs, ... }: {
  # Some tutorial for hypraland setup:
  # youtu.be/61wGzlv12Ds

  programs = {
    #--- Topbar for some various stuff
    waybar = {
      enable = true;
    };


    #--- Wallpaper manager 
    # swww = {
    #   enable = true;
    #};
    # hyprpaper
    # swaybg
    # wpaperd
    # mpvpaper

    #--- Terminal emulator
    alacritty = {
      enable = true;
    };
    # kitty # default wayland emulator

    #--- App lanucher
    rofi = {
      enable = true;

      plugins = with pkgs; [
        rofi-wayland
        rofi-calc
      ];
    }; # Most popular

    #gtk rofi 
    # wofi

    #hyprland wiki also suggest
    # pkgs.bemenu
    # pkgs.fussel
    # pkgs.tofi

    # Some useful apps
    firefox = {
      enable = true;
    };

    # telegram-desktop = {
      # enable = true;
    # };

    #simplex = {
    #  enable = true;
    #};
  };

  services = {
    #--- Notification daemon
    # dunst # general purpose
    mako = { # works better with hyprland
      enable = true;
    };
  };

  #--- Handle window portalling:
  #   - File drag
  #   - Screen sharing
  #   - etc...
  xdg.portal = {
    enable = true;
    # TODO: Specify different portals

    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";
      "$fileManager" = "nautilus";

      monitor = "DP-1,preferred,auto,1";

      bind = [
        # Service keys
        "$mainMod, M, exit"
        "$mainMod, C, killactive"
        "$mainMod, V, togglefloating"
        "$mainMod, P, pseudo"
        "$mainMod, M, togglesplit"

        # Fast app Launch
        "$mainMod, F, exec, firefox"
        "$mainMod, Q, exec, $terminal"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, S, exec, rofi -show drun -show-icons"

        # Tile managment
        "$mainMod, left,  movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up,    movefocus, u"
        "$mainMod, down,  movefocus, d"

        # Utils
        # ",         Print, exec, grimblast copy area"
      ]
      ++ (
        builtins.concatLists ( builtins.genList (
          x: let 
	    ws = let
              c = (x + 1) / 10;
	    in
	      builtins.toString(x + 1 - (c * 10));
	  in [
	    "$mainMod, ${ws},workspace, ${toString(x + 1)}"
            "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
	  ]  
	)  
	10)
      );

      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORM,wayland"
        "XDG_SCREENSHOTS_DIR.~/screens"
      ];

      debug = {
        disable_logs = false;
        enable_stdout_logs = true;
      };

      input = {
        kb_layout = "us,ru";
        kb_variant = "lang";
        kb_options = "grp:win_space_toggle";

        follow_mouse = 1;
        touchpad = {
          natural_scroll = false;
        };

        sensitivity = 0;
      };

      #animations = {
      #  enabled =true;
      #  
      #  # bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      # 
      #  animation = [
      #    "windows,    1, 7, myBezier"
      #    "windowsOut, 1, 7, default popin 80%"
      #    "border,     1, 10, default"
      #    "borderangle 1, 8, default"
      #    "fade,       1, 7, default"
      #    "workspaces, 1, 6, default"
      #  ];
      #};
    };
  };
}
