{ config, lib, ... }:
{
  options = {
    nvidia.enable = lib.mkEnableOption "Enables support for Nvidia graphics card";
    nvidia.intelBusId = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Find this id with `nix shell nixpkgs#pciutils -c lspci | grep ' VGA '` if you have an intel GPU";
      example = "PCI:5:0:0";
    };
    nvidia.amdBusId = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Find this id with `nix shell nixpkgs#pciutils -c lspci | grep ' VGA '` if you have an amd GPU";
      example = "PCI:5:0:0";
    };
    nvidia.nvidiaBusId = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Find this id with `nix shell nixpkgs#pciutils -c lspci | grep ' VGA '` if you have an nvidia GPU";
      example = "PCI:5:0:0";
    };
  };

  config = lib.mkIf config.nvidia.enable {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.graphics.enable = true;

    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      powerManagement.enable = true;
      prime = {
        offload.enable = false;
        sync.enable = true;
        intelBusId = lib.mkDefault config.nvidia.intelBusId;
        amdgpuBusId = lib.mkDefault config.nvidia.amdBusId; 
        nvidiaBusId = lib.mkDefault config.nvidia.nvidiaBusId;
      };
    };

    environment.variables = lib.mkIf config.hyprland.enable {
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
}
