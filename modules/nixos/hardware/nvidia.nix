{
  config,
  lib,
  ...
}: {
  options = {
    custom.hardware.nvidia.enable = lib.mkEnableOption "Enables support for Nvidia graphics card";
    custom.hardware.nvidia.intelBusId = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Find this id with `nix shell nixpkgs#pciutils -c lspci | grep ' VGA '` if you have an intel GPU";
      example = "PCI:5:0:0";
    };
    custom.hardware.nvidia.amdBusId = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Find this id with `nix shell nixpkgs#pciutils -c lspci | grep ' VGA '` if you have an amd GPU";
      example = "PCI:5:0:0";
    };
    custom.hardware.nvidia.nvidiaBusId = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Find this id with `nix shell nixpkgs#pciutils -c lspci | grep ' VGA '` if you have an nvidia GPU";
      example = "PCI:5:0:0";
    };
  };

  config = lib.mkIf config.custom.hardware.nvidia.enable {
    services.xserver.videoDrivers = ["nvidia"];

    hardware.graphics.enable = true;

    hardware.nvidia = {
      modesetting.enable = true;
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      powerManagement.enable = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        sync.enable = false;
        reverseSync.enable = false;
        intelBusId = lib.mkDefault config.custom.hardware.nvidia.intelBusId;
        amdgpuBusId = lib.mkDefault config.custom.hardware.nvidia.amdBusId;
        nvidiaBusId = lib.mkDefault config.custom.hardware.nvidia.nvidiaBusId;
      };
    };

    environment.variables = lib.mkIf config.custom.desktop.hyprland.enable {
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
}
