{
  # https://github.com/dc-tec/nixvim

  imports = [
    ./nixvim/autocmds.nix
    ./nixvim/opts.nix
    ./nixvim/keymaps.nix
    ./nixvim/plugins/_bundle.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    colorschemes.oxocarbon.enable = true;
  };
}
