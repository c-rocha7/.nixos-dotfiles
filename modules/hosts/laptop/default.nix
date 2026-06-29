# modules/hosts/laptop/default.nix
#
# Esqueleto do host `laptop` — a ser completado quando o hardware estiver disponível.
#
# Este arquivo reserva o lugar do host no layout multi-host do repositório.
# Quando o laptop for configurado, este módulo deverá:
#
#   1. Importar os módulos compartilhados já disponíveis:
#        self.nixosModules.nixosBase
#        self.nixosModules.nixosUserCauanixos
#        self.nixosModules.homeCommon
#        self.nixosModules.homeDev
#
#   2. Adicionar módulos específicos do laptop criados neste diretório:
#        laptopIdentity      → identity.nix    (hostname, etc.)
#        laptopHardware      → hardware.nix    (gerado por nixos-generate-config)
#        laptopStorage       → storage.nix     (filesystems e swap)
#        laptopConfiguration → configuration.nix (boot, drivers, serviços)
#
#   3. Definir flake.nixosConfigurations.laptop aqui, de forma análoga
#      ao desktop em modules/hosts/desktop/default.nix.
#
# Não altere modules/hosts/desktop/ — mantenha cada host isolado no seu diretório.
{ ... }: { }
