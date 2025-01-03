{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./common/base.nix
      ./hw-specific/lenovo-laptop/cfg.nix
    ];

  networking.hostName = "lenovo-laptop";
}

