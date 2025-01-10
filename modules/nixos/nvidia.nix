{ config, lib, ... }:
{
  options = {
    nvidia.enable = lib.mkEnableOption "Enables support for Nvidia graphics card";
  };

  config = lib.mkIf config.nvidia.enable {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.opengl.enable = true;

    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      powerManagement.enable = true;
      prime = {
        offload.enable = false;
        sync.enable = true;
      };
    };
  };
}
