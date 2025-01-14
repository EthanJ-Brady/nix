{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.wofi.enable {
    programs.wofi.style = ''${builtins.readFile ./frappe.css}'';
  };
}
