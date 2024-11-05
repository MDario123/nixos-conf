{ ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      format = "$character";
      right_format = "$all";
      character = {
        success_symbol = "[=>>](bold green)";
        error_symbol = "[=>>](bold red)";
      };
      add_newline = false;
      git_branch = {
        disabled = true;
      };
      git_status = {
        disabled = false;
      };
    };
  };
}
