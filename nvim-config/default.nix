{
  config,
  pkgs,
  lib,
  ...
}:

let

  pluginsPath = ./plugins;

  pluginFilenames = builtins.attrNames (builtins.readDir pluginsPath);

  pluginFiles = lib.filter (
    filename:
    let

      entryType = (builtins.readDir pluginsPath)."${filename}";
    in

    entryType == "regular" && lib.hasSuffix ".nix" filename
  ) pluginFilenames;

  pluginImports = lib.map (filename: pluginsPath + "/${filename}") pluginFiles;

in
{

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };

  imports =

    [
      ./core.nix
    ]

    ++ pluginImports;
}
