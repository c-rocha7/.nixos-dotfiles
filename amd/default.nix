{ config, pkgs, ... }:

{
  imports = [
    ./amd-cpu.nix
    ./amd-gpu.nix
  ];
}
