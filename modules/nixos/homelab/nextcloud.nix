{
  config,
  lib,
  ...
}: {
  # In order for this to work properly, you must create the file "/etc/nextcloud-admin-pass" that just contains the password for the root user

  options = {
    custom.homelab.nextcloud.enable = lib.mkEnableOption "Enables nextcloud";
  };

  config = lib.mkIf config.custom.homelab.nextcloud.enable {
    services.nextcloud = {
      enable = true;
      hostName = "localhost";
      config = {
        adminpassFile = "/etc/nextcloud-admin-pass";
        dbtype = "sqlite";
      };
      settings = {
        trusted_domains = [
          "mohs.tailnet.ethanbrady.xyz"
          "nextcloud.ethanbrady.xyz"
        ];
      };
    };
  };
}
