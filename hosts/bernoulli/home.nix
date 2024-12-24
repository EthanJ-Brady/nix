{ ... }:
{
    profiles.apps = true;
    profiles.programming = true;
    profiles.shell = true;
    profiles.theme = true;

    ssh.enable = true;
    nixvim.enable = true;
    zettel.enable = true;

    home.username = "ethan";
    home.homeDirectory = "/home/ethan";

    home.stateVersion = "23.11";

    programs.home-manager.enable = true;
}
