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

    hardware.opengl.enable = true;

    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      powerManagement.enable = true;
      prime = {
        offload.enable = false;
        sync.enable = true;
        intelBusId = config.nvidia.intelBusId;
        amdgpuBusId = config.nvidia.amdBusId;
        nvidiaBusId = config.nvidia.nvidiaBusId;
      };
    };
  };
}
