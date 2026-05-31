{ config, pkgs, ... }:

{
    zramSwap = 
    {
        enable = true;
        memoryMax = 8192 * 1024 * 1024;
    };
}
