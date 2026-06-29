{ ... }:

{
  flake.nixosModules.desktopIdentity = { ... }:
    {
      networking.hostName = "nixos";
    };
}
