#!/bin/bash

# basic disk partitioning 
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode ./nix-cfg/lenovo-laptop/disko.nix

