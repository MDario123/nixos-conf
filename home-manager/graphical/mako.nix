{ ... }:
{
  services.mako = {
    enable = true;
    settings = {
      max-visible = 5;
      output = "eDP-1";
      sort = "-time";
      layer = "overlay";
      anchor = "top-right";
      font = "FantasqueSansM Nerd Font Mono";
      background-color = "#1E1E1E";
      text-color = "#D0F0F0";
      actions = true;
      width = 300;
      height = 200;
      margin = "10";
      padding = "5";
      border-size = 2;
      border-color = "#F38BA8";
      border-radius = 6;
      progress-color = "over #F38BA870";
      default-timeout = 5000;
      format = "<b>%s</b>\\n%b";
      group-by = "app-name,summary";
      grouped = {
        format = "<b>%s</b>\\n%b";
      };
    };
  };
}
