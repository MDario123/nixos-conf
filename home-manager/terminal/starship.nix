{ ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      format = "$time$all$character";
      character = {
        success_symbol = "[=>>](bold green)";
        error_symbol = "[=>>](bold red)";
      };
      add_newline = false;

      time = {
        disabled = false;
        format = "[\\[$time\\]]($style) ";
        symbol = "󰥔 ";
      };

      aws = {
        disabled = true;
        format = "[\\[$symbol$region\\]]($style)";
        symbol = "☁️ ";
      };
      git_branch = {
        format = "[\\[$symbol$branch(:$remote_branch)\\]]($style)";
        ignore_branches = [
          "main"
          "master"
        ];
      };
      git_status = {
        disabled = false;
      };
      nix_shell = {
        format = "[\\[$symbol$state\\]]($style)";
        symbol = "❄️ ";
      };
      python = {
        format = "[\\[$symbol$version\\]]($style)";
        symbol = "🐍 ";
      };
    };
  };
}
