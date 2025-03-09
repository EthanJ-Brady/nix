{
  config,
  lib,
  ...
}: {
  options = {
    custom.shell.zettel.enable = lib.mkEnableOption "Installs the zettel script to local user binaries";
  };

  config = lib.mkIf config.custom.shell.zettel.enable {
    home.file.".local/bin/zettel" = {
      source = ./zettel;
    };
  };
}
