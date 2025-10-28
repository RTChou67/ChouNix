{ config, pkgs, ... }:
{
  programs.nixvim.plugins.notify = {
    enable = true;
    settings = {
      stages = "fade_in_slide_out";
      timeout = 2000;
      render = "compact";
      top_down = false;
    };
  };
}
