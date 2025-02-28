{pkgs, ...}: {
  imports = [
    ./networking.nix # generated at runtime by nixos-infect
    ./host.nix
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "morse";
  networking.domain = "";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [''ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBGq2C+guMbvTa7J23p3DicQiIGKRliDqgNw7O/L0ZS1ljFmi78tP/ihiHauuj06I2qFbYkJlVxmgcoSf/L7k150='' ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICY/CZ3vpiviPratsI4ygYjPAQ42Tl5vrajEJfOiQcS8 ethanbrady@Mac.localdomain''];
  system.stateVersion = "23.11";

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    ghostty
  ];

  users.users.ethan = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };
}
