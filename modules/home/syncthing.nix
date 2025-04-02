{
  config,
  lib,
  ...
}: {
  options = {
    custom.syncthing.enable = lib.mkEnableOption "Enables syncthing";
  };

  config = lib.mkIf config.custom.syncthing.enable {
    services = {
      syncthing = {
        enable = true;
        overrideDevices = true;
        overrideFolders = true;
        settings = {
          devices = {
            "newton" = {id = "LEXBBIA-TNBDP4Q-UG4KF3E-EIUG355-EPZZTFO-OX76U7P-WTSVMHZ-SZ3MWAF";};
          };
          folders = {
            "Files" = {
              path = "/Users/ethanbrady/Files";
              devices = ["newton"];
            };
          };
        };
      };
    };
  };
}
