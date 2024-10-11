{ ... }:
{
  programs.git = {
    enable = true;
    aliases = {
      graph = "log --oneline --graph --decorate --all";
    };
  };
}
