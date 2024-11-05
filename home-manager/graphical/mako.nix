{ ... }:
{
  services.mako = {
    enable = true;
    maxVisible = 5;
    output = "eDP-1";
    sort = "-time";
    layer = "overlay";
    anchor = "top-right";
    font = "FantasqueSansM Nerd Font Mono";
    backgroundColor = "#1E1E1E";
    textColor = "#D0F0F0";
    actions = true;
    width = 300;
    height = 200;
    margin = "10";
    padding = "5";
    borderSize = 2;
    borderColor = "#F38BA8";
    borderRadius = 6;
    progressColor = "over #F38BA870";
    defaultTimeout = 5000;
    format = "<b>%s</b>\\n%b";
    groupBy = "app-name,summary";
    extraConfig = ''
      [grouped]
      format=<b>%s</b>\n%b
    '';
  };
}
