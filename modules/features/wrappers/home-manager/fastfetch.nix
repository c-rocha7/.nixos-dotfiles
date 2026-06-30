{ self, inputs, ... }:

{
  flake.nixosModules.fastfetch = { pkgs, ... }:
    {
      home-manager.users.cauanixos = {
        programs.fastfetch = {
          enable = true;
          package = self.packages.${pkgs.stdenv.hostPlatform.system}.myFastfetch;
        };
      };
    };

  perSystem = { pkgs, ... }:
    {
      packages.myFastfetch = inputs.wrapper-modules.wrappers.fastfetch.wrap {
        inherit pkgs;

        settings = {
          display = {
            separator = " ";
          };
          modules = [
            {
              key = "╭───────────╮";
              type = "custom";
            }
            {
              key = "│ {#31} user    {#keys}│";
              type = "title";
              format = "{user-name}";
            }
            {
              key = "│ {#32}󰇅 hname   {#keys}│";
              type = "title";
              format = "{host-name}";
            }
            {
              key = "│ {#34}{icon} distro  {#keys}│";
              type = "os";
            }
            {
              key = "│ {#35} kernel  {#keys}│";
              type = "kernel";
            }
            {
              key = "│ {#36}󰖟 packages{#keys}│";
              type = "packages";
            }

            {
              key = "│ {#31} term    {#keys}│";
              type = "terminal";
            }
            {
              key = "│ {#32} shell   {#keys}│";
              type = "shell";
            }
            {
              key = "│ {#33}󰍛 cpu     {#keys}│";
              type = "cpu";
              showPeCoreCount = true;
            }
            {
              key = "│ {#34}󰍛 gpu     {#keys}│";
              type = "gpu";
            }
            {
              key = "│ {#36} memory  {#keys}│";
              type = "memory";
            }
            {
              key = "│ {#34}󰉉 disk    {#keys}│";
              type = "disk";
              folders = "/";
            }
            {
              key = "│ {#36}󰇄 desktop {#keys}│";
              type = "de";
            }
            {
              key = "│ {#34}󰊯 theme   {#keys}│";
              type = "theme";
            }
            {
              key = "│ {#35}󰊯 icons   {#keys}│";
              type = "icons";
            }
            {
              key = "│ {#36}󰊯 cursor  {#keys}│";
              type = "cursor";
            }
            {
              key = "│ {#31}󰊯 font    {#keys}│";
              type = "font";
            }
            {
              key = "├───────────┤";
              type = "custom";
            }
            {
              key = "│ {#39} colors  {#keys}│";
              type = "colors";
              symbol = "circle";
            }
            {
              key = "╰───────────╯";
              type = "custom";
            }
          ];
        };
      };
    };
}
