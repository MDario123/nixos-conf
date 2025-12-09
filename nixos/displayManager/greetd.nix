{ pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet -r --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };
}
