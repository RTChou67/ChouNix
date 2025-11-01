# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./nvim-config
    # include NixOS-WSL modules
    # <nixos-wsl/modules> # This is likely now handled by your flake.nix, you can remove it.
  ];

  wsl.enable = true;
  wsl.defaultUser = "rtchou";
  environment.systemPackages = with pkgs; [
    autoconf
    autogen
    automake
    black
    btop
    bzip2
    cargo
    clang-tools
    cloc
    cmake
    curl
    diffutils
    direnv
    fastfetch
    fd
    fish
    gawk
    gfortran
    git
    gnumake
    gnupatch
    gsl
    hdf5
    home-manager
    htop
    hyfetch
    lazygit
    less
    libtool
    libxml2
    lsd
    lua
    luarocks
    #miniforge
    nodejs
    nixfmt-rfc-style
    nushell
    pkg-config
    python3
    ripgrep
    shfmt
    spglib
    statix
    stylua
    trash-cli
    tree
    trexio
    unzip
    uv
    vim
    wget
    which
    xclip
    xorg.fontadobe100dpi
    xorg.fontadobe75dpi
    xorg.fontbhttf
    xorg.fontcursormisc
    xorg.mkfontdir
    xorg.mkfontscale
    yarn
    zip
    zlib-ng
    zsh

  ];
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    interactiveShellInit = lib.mkMerge [
      ''
        activate-pybase() {
        eval "$(cd /etc/nixos/python-base && direnv export zsh)"
        }
        deactivate-pybase() {
        eval "$(cd /etc/nixos/empty-env && direnv export zsh)"
        }
      ''
    ];
    syntaxHighlighting.enable = true;
    shellAliases = {
      cd = "z";
      vi = "nvim";
      vim = "nvim";
      ls = "lsd";
      rm = "trash";
    };
    ohMyZsh = {
      enable = true;
      plugins = [
        "history"
        "dirhistory"
        "git"
        "colorize"
        "command-not-found"
      ];
      theme = "rtchou";
      custom = "/etc/nixos/omz-config";
    };

  };
  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];
  nixpkgs.config.allowUnfree = true;
  users.defaultUserShell = pkgs.zsh;
  #services.flatpak.enable = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
