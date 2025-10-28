{ config, pkgs, ... }:
{
  # 修正：使用正确的模块名称 "web-devicons"
  programs.nixvim.plugins.web-devicons.enable = true;
}
