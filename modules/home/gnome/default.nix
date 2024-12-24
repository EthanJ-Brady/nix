{
  lib,
  ...
}:
{
  imports = [
    ./extensions
  ];

  options = {
    gnome.enable = lib.mkEnableOption "Enables user level gnome configuration such as extensions";
  };
}
