{ config, pkgs, ... }:
{
  programs.nixvim.plugins.colorizer = {
    enable = true;
    settings = {
      user_default_options = {
        RGB = true;
        RRGGBB = true;
        names = false;
        RRGGBBAA = true;
        rgb_fn = true;
        hsl_fn = true;
        mode = "background";
      };
    };
  };
}
