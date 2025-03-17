{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.custom.desktop.wofi.enable {
    programs.wofi.style = ''${builtins.readFile ./frappe.css}'';
  };
}
