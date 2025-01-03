{ config, lib, pkgs, ... }:

{
  time.timeZone = "Indian/Christmas";

  i18n.defaultLocale = "ru_RU.UTF-8";

  console = {
    font = "cyr-sun16";
    keyMap = "ruwin_alt_sh-UTF-8";
  };

  #services.xserver = {
  #  layout = "us,ru";
  #  xkbOptions = "grp:caps_"
  #};

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # users.defaultUserShell = pkgs.zsh;

  users.groups.nixcfg = {};

  users.users = {
    root = {
      shell = pkgs.zsh;
      ignoreShellProgramCheck = true; # Its a hack. maybe i sshould use another way yo specify default shell?
      extraGroups = [ "audio" "nixcfg" "wheel" "input" "networkmanager" ]; # Enable ‘sudo’ for the user.

    };

    adevald = {
      isNormalUser = true;
      extraGroups = [ "audio" "nixcfg" "wheel" "input" "networkmanager" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        firefox
        tree
      ];
    };
  };

  #--- Sound enabling
  #hardware.pulseaudio = { 
  #  enable = true;
  #  support32Bit = true;
  #};

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
     vim
     lynx
     #toybox
     git 
     dmidecode
     pciutils 
     usbutils
     wirelesstools
     fastfetch
     pulseaudio
     nb

     home-manager

     # shell
     thefuck

     # Window-manager stuff
     seatd
     polybar
     waybar

     #File managers
     nautilus

     # Screenshoting
     grim
     grimblast

     # Wayland wallpaper managers
     swww

     # Messengers
     telegram-desktop
     simplex-chat-desktop
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = ["NerdFontsSymbolsOnly"]; })
  ];

  programs.hyprland.enable = true;
  
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  system.stateVersion = "24.05"; # Did you read the comment?

}

