{ ... }:
{
  programs.nixvim.plugins.lint = {
    enable = true;

    lintersByFt = {
      python = [ "flake8" ];
      nix = [ "statix" ];

    };
  };

}
