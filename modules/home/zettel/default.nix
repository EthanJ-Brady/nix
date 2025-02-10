{
  config,
  lib,
  ...
}: {
  options = {
    zettel.enable = lib.mkEnableOption "Installs the zettel script to local user binaries";
  };

  config = lib.mkIf config.zettel.enable {
    home.file.".local/bin/zettel" = {
      source = ./zettel;
    };
  };
}
