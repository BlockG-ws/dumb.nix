{ pkgs, ... }:
{
  environment.systemPackages = [
      pkgs.spaceship-prompt
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      la = "ls -a";
      sedit = "sudo -e";
    };

    histSize = 10000;
    histFile = "$HOME/.local/state/zsh_history";
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];
    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "z"
      ];
      theme = "spaceship";
    };
  };
}