{ config, pkgs, ... }:

{
    programs.mise = 
    {
        enable = true;
        enableZshIntegration = true;
        package = pkgs.unstable.mise;

        globalConfig = 
        {
            settings = 
            {
                all_compile = false;     
                experimental = true;
            };

            tools = 
            {
                bun         = "latest";
                go          = "latest";
                java        = "latest";
                lazydocker  = "latest";
                lazygit     = "latest";
                node        = "latest";
                pnpm        = "latest";
                python      = "latest";
                ruby        = "latest";
                rust        = "latest";
            };
        };
    };
}
